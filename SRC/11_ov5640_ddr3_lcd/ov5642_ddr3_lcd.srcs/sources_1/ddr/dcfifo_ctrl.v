`timescale 1 ns / 1 ns
module dcfifo_ctrl
(
	//global clock
	input				    clk_ref,		      //全局时钟
	input 			        clk_write,		      //fifo写数据时钟
	input				    clk_read,		      //fifo读数据时钟
	input 			        rst_n,			      //全局复位
	
	//burst length
	input		[9:0]	 	wr_length,		      //ddr读突发长度
	input		[9:0]	 	rd_length,		      //ddr写突发长度
	input		[28:0]   	wr_addr,		      //ddr写地址
	input		[28:0]   	wr_max_addr,	      //ddr最大写地址
	input		[28:0]   	rd_addr,		      //ddr读地址
	input		[28:0] 	    rd_max_addr,	      //ddr最大读地址	
	input				 	vout_vs,		      //
    input				 	vin_vs,		          //
	
	//wrfifo:  fifo 2 ddr
	input 			 	   wrf_wrreq,		      //写入ddr数据缓存fifo输入请求,作为fifo写信号
	input		[255:0]    wrf_din,		         //写入ddr数据缓存fifo写入总线（写入sdram数据）
	output 	reg	 	       ddr_wr_req,	         //写入ddr请求信号
	input 			 	   ddr_wr_ack,	         //写入ddr响应信号,作为fifo读信号
	output	    [255:0]    ddr_din,		         //写入ddr数据缓存fifo输出数据总线
	output	reg	[28:0] 	   ddr_wraddr,	        //写入ddr时地址暂存器
    input                  ddr_wr_finish,       //写入ddr数据完成
	
	//rdfifo: sdram 2 fifo
	input 				   rdf_rdreq,		      //读取ddr数据缓存fifo输出请求
	output	    [255:0]    rdf_dout,		      //读取ddr数据缓存fifo输出总线（读取sdram数据）
	output 	reg			   ddr_rd_req,	          //读取ddr请求信号
	input 				   ddr_rd_ack,	          //读取ddr响应信号,作为fifo的输写有效信号
	input		[255:0]    ddr_dout,		      //读取ddr数据缓存fifo输入数据
	output	reg	[28:0] 	   ddr_rdaddr,	          //读取ddr时地址暂存器，{bank[1:0],row[11:0],column[7:0]} 
   input                   ddr_rd_finish,         //读ddr数据完成
	
	//sdram address control	
	input				   ddr_init_done,	       //ddr初始化完成信号
	output	reg		       frame_write_done,	   //ddr write one frame
	output	reg		       frame_read_done	       //ddr read one frame
	
);


//------------------------------------------------
//?同步sdram读写地址初始值复位信号
reg vin_vs_d0;
reg vin_vs_d1;
reg vin_vs_d2;

reg vout_vs_d0;
reg vout_vs_d1;
reg vout_vs_d2;
always@(posedge clk_ref)
begin
    vin_vs_d0 <= vin_vs;
    vin_vs_d1 <= vin_vs_d0;
    vin_vs_d2 <= vin_vs_d1;
end

always@(posedge clk_ref)
begin
    vout_vs_d0 <= vout_vs;
    vout_vs_d1 <= vout_vs_d0;
    vout_vs_d2 <= vout_vs_d1;
end

wire	wr_load_flag = ~vin_vs_d2 & vin_vs_d1;	    //写地址加载上升沿标志位
wire	rd_load_flag = ~vout_vs_d2 & vout_vs_d1;	//读地址加载上升沿标志位

//------------------------------------------------
//ddr写地址产生模块（优先）
always @(posedge clk_ref or negedge rst_n)
begin
	if(!rst_n)
		begin
		ddr_wraddr <= 29'd0;	
		frame_write_done <= 1'b0;
		end			
	else if(wr_load_flag)						//加载ddr写入基地址
		begin
		ddr_wraddr <= wr_addr;	
		frame_write_done <= 1'b0;	
		end		
	else if(ddr_wr_finish)						//突发写入完毕
		begin
		if(ddr_wraddr < wr_max_addr - wr_length)
			begin
			ddr_wraddr <= ddr_wraddr + wr_length;   //ddr的地址增加
			frame_write_done <= 1'b0;
			end
		else
			begin
			ddr_wraddr <= ddr_wraddr;		//防止溢出，锁存地址
			frame_write_done <= 1'b1;
			end
		end
	else
		begin
		ddr_wraddr <= ddr_wraddr;			//锁存地址
		frame_write_done <= frame_write_done;
		end
end

//------------------------------------------------
//ddr读地址产生模块(其次)
always @(posedge clk_ref or negedge rst_n)
begin
	if(!rst_n)
		begin
		ddr_rdaddr <= 29'd0;
		frame_read_done <= 0;
		end
	else if(rd_load_flag)						//加载ddr读取基地址
		begin
		ddr_rdaddr <= rd_addr;
		frame_read_done <= 0;
		end
	else if(ddr_rd_finish)						//突发写入完毕
		begin
		if(ddr_rdaddr < rd_max_addr - rd_length)
			begin
			ddr_rdaddr <= ddr_rdaddr + rd_length;
			frame_read_done <= 0;
			end
		else
			begin
			ddr_rdaddr <= ddr_rdaddr;		//防止溢出，锁存地址
			frame_read_done <= 1;
			end
		end
	else
		begin
		ddr_rdaddr <= ddr_rdaddr;			//锁存地址
		frame_read_done <= frame_read_done;
		end
end


//-------------------------------------
//ddr 读写信号产生模块
wire	[9:0] 	wrf_use;
wire	[9:0] 	rdf_use;
reg wr_flag;
reg rd_flag;
always@(posedge clk_ref or negedge rst_n)
begin
	if(!rst_n)	
		begin
		ddr_wr_req <= 0;
		wr_flag <= 0;
		end
	else if(wr_load_flag)
	begin
	   wr_flag <= 0;
	   ddr_wr_req <= 0;
	end
	else if(ddr_init_done == 1'b1)
		begin						      //写入优先，带宽内防止数据丢失
		if(wrf_use >= wr_length & !wr_flag)	//写入FIFO的数据数量超过burst长度,写DDR开始	       
			begin					      //wrfifo满突发长度
			ddr_wr_req <= 1;		//写ddr使能
			wr_flag <= 1;
			end
		else if(ddr_wr_finish)//读FIFO里的数据数量小于burst长度,读DDR开始	
			begin					//rdfifo满突发长度
			ddr_wr_req <= 0;		//写ddr空闲
			wr_flag <= 0;
			end
		end
	else
		begin
		ddr_wr_req <= 0;			//写ddr空闲
		end
end


always@(posedge clk_ref or negedge rst_n)
begin
	if(!rst_n)	
		begin
		ddr_rd_req <= 0;
		rd_flag <= 0;
		end
	else if(rd_load_flag)
	begin
    ddr_rd_req <= 0;
    rd_flag <= 0;
    end
	else if(ddr_init_done == 1'b1)
		begin						      //写入优先，带宽内防止数据丢失
		 if(rdf_use <= rd_length &  !rd_flag)//读FIFO里的数据数量小于burst长度,读DDR开始	
			begin					//rdfifo满突发长度
			ddr_rd_req <= 1;		//读ddrm使能
			rd_flag <= 1;
			end
		else if(ddr_rd_finish)
			begin
			ddr_rd_req <= 0;		//读ddr空闲
			rd_flag <= 0;
			end
		end
	else
		begin
		ddr_rd_req <= 0;			//读ddr空闲
		end
end
//------------------------------------------------
//例化ddr写入数据缓存fifo模块
wrfifo	u_wrfifo
(
	.rst		    (~rst_n | wr_load_flag ),			//wrfifo异步清零信号（很重要）| wr_load_flag

	//input 2 fifo
	.wr_clk		    (clk_write),		//wrfifo写时钟
	.wr_en		    (wrf_wrreq),		//wrfifo写使能信号
	.din		    (wrf_din),			//wrfifo数据输入总线
	//fifo 2sdram
	.rd_clk		    (clk_ref),			//wrfifo读时钟100MHz
	.rd_en		    (ddr_wr_ack),		//wrfifo读使能信号
	.dout			(ddr_din),		//wrfifo数据输出总线
	//user port
   .full            (), // output full
   .empty           (), // output empty
   .rd_data_count	(wrf_use),			//wrfifo存储数据总量
   .wr_data_count	()			
);	


//------------------------------------------------
//例化ddr读出数据缓存fifo模块
rdfifo	u_rdfifo
(
	.rst		    (~rst_n  | rd_load_flag),		//rdfifo异步清零信号   
	//sdram 2 fifo
	.wr_clk		    (clk_ref),       	//rdfifo写时钟
	.wr_en		    (ddr_rd_ack),  	//rdfifo写使能信号
	.din		    (ddr_dout),  		//rdfifo数据输入总线
	//fifo 2 output 
	.rd_clk		    (clk_read),         //rdfifo读时钟50MHz
	.rd_en		    (rdf_rdreq),     	//rdfifo读使能信号
	.dout			(rdf_dout),			//rdfifo数据输出总线
	//user port
	.full           (), // output full
    .empty(), // output empty
	.rd_data_count	(),                //rdfifo存储数据总量
	.wr_data_count	(rdf_use)          //rdfifo存储数据总量
);


endmodule
