`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////
// Module Name:    sd_test
///////////////////////////////////////////////////////////////////
module sd_test(
                    input sys_clk_p,
                    input sys_clk_n,    
					input rst_n,
					
					output SD_clk,					
					output SD_cs,
					output SD_datain,
					input  SD_dataout
					
    );

wire CLKFB;
wire CLK0;
wire CLKDV;
wire CLKFX;
wire CLK2X;
wire clock100M;

wire SD_datain_i;
wire SD_datain_w;
wire SD_datain_r;
reg SD_datain_o;

wire SD_cs_i;
wire SD_cs_w;
wire SD_cs_r;
reg SD_cs_o;


reg [31:0]read_sec;
reg read_req;

reg [31:0]write_sec;
reg write_req;

wire [7:0]mydata_o;
wire myvalid_o;

wire init_o;             //SD 初始化完成标识
wire write_o;            //SD blcok写完成标识
wire read_o;             //SD blcok读完成标识

reg [3:0] sd_state;

wire [3:0] initial_state;
wire [3:0] write_state;
wire [3:0] read_state;

wire rx_valid;

parameter STATUS_INITIAL=4'd0;
parameter STATUS_WRITE=4'd1;
parameter STATUS_READ=4'd2;
parameter STATUS_IDLE=4'd3;

assign SD_cs=SD_cs_o;
assign SD_datain=SD_datain_o;

////////////////差分时钟转换成单端时钟////////////////////////
    wire sys_clk_ibufg;
     IBUFGDS #
           (
            .DIFF_TERM    ("FALSE"),
            .IBUF_LOW_PWR ("FALSE")
            )
           u_ibufg_sys_clk
             (
              .I  (sys_clk_p),
              .IB (sys_clk_n),
              .O  (sys_clk_ibufg)
              );
 ////////////////产生25Mhz的SD卡读写时钟////////////////////////    
 wire locked;        
 wire ila_clk; 
   pll pll_inst
             (// Clock in ports
              .clk_in1(sys_clk_ibufg),      // IN
              .clk_out1(SD_clk),     // 25MHz)
              .clk_out2(ila_clk),     // 100MHz)             
              .reset(0),               // reset input 
              .locked(locked));        // OUT
/*******************************/
//SD卡初始化,block写,block读	
/*******************************/
always @ ( posedge SD_clk or negedge rst_n )
    if( !rst_n ) begin
			sd_state <= STATUS_INITIAL;
			read_req <= 1'b0;
			read_sec <= 32'd0;
			write_req <= 1'b0;
			write_sec <= 32'd0;			
	 end
	 else 
	     case( sd_state )

	      STATUS_INITIAL:      // 等待sd卡初始化结束
			if( init_o ) begin sd_state <= STATUS_WRITE; write_sec <= 32'd0; write_req<=1'b1; end
			else begin sd_state <= STATUS_INITIAL; end	
		  
	      STATUS_WRITE:        //等待sd卡block写结束
			if( write_o ) begin sd_state <= STATUS_READ; read_sec <= 32'd0; read_req<=1'b1; end
			else begin write_req<=1'b0; sd_state <= STATUS_WRITE; end
	
			STATUS_READ:        //等待sd卡block读结束
			if( read_o ) begin sd_state <= STATUS_IDLE; end
			else begin read_req<=1'b0; sd_state <= STATUS_READ;  end
			
	      STATUS_IDLE:        //空闲状态
			sd_state <= STATUS_IDLE;
			
			default: sd_state <= STATUS_IDLE;
	      endcase

//SD卡初始化程序				
sd_initial	sd_initial_inst(					
						.rst_n(rst_n),
						.SD_clk(SD_clk),
						.SD_cs(SD_cs_i),
						.SD_datain(SD_datain_i),
						.SD_dataout(SD_dataout),
						.rx(),
						.init_o(init_o),
						.state(initial_state)

);


//SD卡block读程序, 写512个0~255,0~255的数据			 
sd_write	sd_write_inst(   
						.SD_clk(SD_clk),
						.SD_cs(SD_cs_w),
						.SD_datain(SD_datain_w),
						.SD_dataout(SD_dataout),
						
						.init(init_o),
						.sec(write_sec),
						.write_req(write_req),
						.mystate(write_state),
						.rx_valid(rx_valid),

						.write_o(write_o)			
						
    );

//SD卡block读程序, 读512个数据			 
sd_read	sd_read_inst(   
						.SD_clk(SD_clk),
						.SD_cs(SD_cs_r),
						.SD_datain(SD_datain_r),
						.SD_dataout(SD_dataout),
						
						.init(init_o),
						.sec(read_sec),
						.read_req(read_req),
						
						.mydata_o(mydata_o),
						.myvalid_o(myvalid_o),
		
						.data_come(data_come),
						.mystate(read_state),
						
						.read_o(read_o)
						
    );

always @(*)
begin
	 case( sd_state )
	 STATUS_INITIAL: begin SD_cs_o<=SD_cs_i;SD_datain_o<=SD_datain_i; end
	 STATUS_WRITE: begin SD_cs_o<=SD_cs_w;SD_datain_o<=SD_datain_w; end
	 STATUS_READ: begin SD_cs_o<=SD_cs_r;SD_datain_o<=SD_datain_r; end
	 default: begin SD_cs_o<=1'b1;SD_datain_o<=1'b1; end	 
	 endcase
end


/***************************/
//chipscope icon和ila, 用于观察信号//
/***************************/	
wire [3:0] probe0;
wire probe1;
wire probe2;
wire probe3;
wire [3:0] probe4;
wire probe5;
wire probe6;
wire probe7;
wire probe8;
wire [3:0] probe9;
wire probe10;
wire probe11;
wire probe12;
wire [3:0] probe13;
wire probe14;
wire probe15;
wire [7:0] probe16;

ila_0 u_ila_0(
	.clk(ila_clk),
	.probe0(probe0),
	.probe1(probe1),
	.probe2(probe2),
	.probe3(probe3),
	.probe4(probe4),
	.probe5(probe5),
	.probe6(probe6),
	.probe7(probe7),	
	.probe8(probe8),
	.probe9(probe9),
	.probe10(probe10),
    .probe11(probe11),    
 	.probe12(probe12),
    .probe13(probe13), 
    .probe14(probe14),    
    .probe15(probe15),
    .probe16(probe16)              										

);
	                                            

assign  probe0[3:0]=sd_state;     
assign  probe1=init_o;  
assign  probe2=write_o;  
assign  probe3=read_o;  
assign  probe4[3:0]=initial_state;
    
assign  probe5=SD_clk;                                                
assign  probe6=SD_cs;          
assign  probe7=SD_datain;       
assign  probe8=SD_dataout;    

assign  probe9[3:0]=write_state; 
assign  probe10=write_req;     
assign  probe11=rx_valid;

assign  probe12=read_req;
assign  probe13[3:0]=read_state;

assign probe14=data_come;
assign probe15=myvalid_o;
assign probe16[7:0]=mydata_o;

endmodule
