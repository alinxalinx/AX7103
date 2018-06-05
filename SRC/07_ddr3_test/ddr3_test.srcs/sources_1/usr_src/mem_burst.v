/*本模块完成对ddr2 IP的包装，方便后续模块使用，也方便程序的移植，如果更换平台，更新这个文件即可
*/
module mem_burst
#(
	parameter MEM_DATA_BITS = 64,
	parameter ADDR_BITS = 24
)
(
	input rst,                                 /*复位*/
	input mem_clk,                               /*接口时钟*/
	input rd_burst_req,                          /*读请求*/
	input wr_burst_req,                          /*写请求*/
	input[9:0] rd_burst_len,                     /*读数据长度*/
	input[9:0] wr_burst_len,                     /*写数据长度*/
	input[ADDR_BITS - 1:0] rd_burst_addr,        /*读首地址*/
	input[ADDR_BITS - 1:0] wr_burst_addr,        /*写首地址*/
	output rd_burst_data_valid,                  /*读出数据有效*/
	output wr_burst_data_req,                    /*写数据信号*/
	output[MEM_DATA_BITS - 1:0] rd_burst_data,   /*读出的数据*/
	input[MEM_DATA_BITS - 1:0] wr_burst_data,    /*写入的数据*/
	output rd_burst_finish,                      /*读完成*/
	output wr_burst_finish,                      /*写完成*/
	output burst_finish,                         /*读或写完成*/
	
	///////////////////
   output[ADDR_BITS-1:0]                       app_addr,
   output[2:0]                                 app_cmd,
   output                                      app_en,
   output [MEM_DATA_BITS-1:0]                  app_wdf_data,
   output                                      app_wdf_end,
   output [MEM_DATA_BITS/8-1:0]                app_wdf_mask,
   output                                      app_wdf_wren,
   input [MEM_DATA_BITS-1:0]                   app_rd_data,
   input                                       app_rd_data_end,
   input                                       app_rd_data_valid,
   input                                       app_rdy,
   input                                       app_wdf_rdy,
   input                                       ui_clk_sync_rst,  
   input                                       init_calib_complete
);

assign app_wdf_mask = {MEM_DATA_BITS/8{1'b0}};

parameter IDLE = 3'd0;
parameter MEM_READ = 3'd1;
parameter MEM_READ_WAIT = 3'd2;
parameter MEM_WRITE  = 3'd3;
parameter MEM_WRITE_WAIT = 3'd4;
parameter READ_END = 3'd5;
parameter WRITE_END = 3'd6;
parameter MEM_WRITE_FIRST_READ = 3'd7;
reg[2:0] state;	
reg[9:0] rd_addr_cnt;
reg[9:0] rd_data_cnt;
reg[9:0] wr_addr_cnt;
reg[9:0] wr_data_cnt;

reg[2:0] app_cmd_r;
reg[ADDR_BITS-1:0] app_addr_r;
reg app_en_r;
reg app_wdf_end_r;
reg app_wdf_wren_r;
assign app_cmd = app_cmd_r;
assign app_addr = app_addr_r;
assign app_en = app_en_r;
assign app_wdf_end = app_wdf_end_r;
//assign wr_burst_data_req = wr_burst_data_req_r;
assign app_wdf_data = wr_burst_data;
assign app_wdf_wren = app_wdf_wren_r & app_wdf_rdy;
assign rd_burst_finish = (state == READ_END);
assign wr_burst_finish = (state == WRITE_END);
assign burst_finish = rd_burst_finish | wr_burst_finish;

assign rd_burst_data = app_rd_data;
assign rd_burst_data_valid = app_rd_data_valid;
/* always@(posedge mem_clk or posedge rst)
begin
	if(rst)
	begin
		app_wdf_wren_r <= 1'b0;
	end
	else
		app_wdf_wren_r <= wr_burst_data_req_r;	``
end */

assign wr_burst_data_req = (state == MEM_WRITE) & app_wdf_rdy ;

always@(posedge mem_clk or posedge rst)
begin
	if(rst)
	begin
		app_wdf_wren_r <= 1'b0;
	end
	else if(app_wdf_rdy)
		app_wdf_wren_r <= wr_burst_data_req;
end

always@(posedge mem_clk or posedge rst)
begin
	if(rst)
	begin
		state <= IDLE;
		app_cmd_r <= 3'b000;
		app_addr_r <= 0;
		app_en_r <= 1'b0;
		//wr_burst_data_req_r <= 1'b0;
		rd_addr_cnt <= 0;
		rd_data_cnt <= 0;
		wr_addr_cnt <= 0;
		wr_data_cnt <= 0;
		app_wdf_end_r <= 1'b0;
		//app_wdf_wren_r <= 1'b0;
	end
	else if(init_calib_complete ===  1'b1)
	begin
		case(state)
			IDLE:
			begin
				if(rd_burst_req)
				begin
					state <= MEM_READ;
					app_cmd_r <= 3'b001;
					app_addr_r <= {rd_burst_addr,3'd0};
					app_en_r <= 1'b1;
				end
				else if(wr_burst_req)
				begin
					state <= MEM_WRITE;
					app_cmd_r <= 3'b000;
					app_addr_r <= {wr_burst_addr,3'd0};
					app_en_r <= 1'b1;
					wr_addr_cnt <= 0;
					app_wdf_end_r <= 1'b1;
					wr_data_cnt <= 0;
				end
			end
			MEM_READ:
			begin
				if(app_rdy)
				begin
					app_addr_r <= app_addr_r + 8;
					if(rd_addr_cnt == rd_burst_len - 1)
					begin
						state <= MEM_READ_WAIT;
						rd_addr_cnt <= 0;
						app_en_r <= 1'b0;
					end
					else
						rd_addr_cnt <= rd_addr_cnt + 1;
				end
				
				if(app_rd_data_valid)
				begin
					if(rd_data_cnt == rd_burst_len - 1)
					begin
						rd_data_cnt <= 0;
						state <= READ_END;
					end
					else
					begin
						rd_data_cnt <= rd_data_cnt + 1;
					end
				end
			end
			MEM_READ_WAIT:
			begin
				if(app_rd_data_valid)
				begin
					if(rd_data_cnt == rd_burst_len - 1)
					begin
						rd_data_cnt <= 0;
						state <= READ_END;
					end
					else
					begin
						rd_data_cnt <= rd_data_cnt + 1;
					end
				end
			end
			MEM_WRITE_FIRST_READ:
			begin
				app_en_r <= 1'b1;
				state <= MEM_WRITE;
				wr_addr_cnt <= 0;
				//app_wdf_wren_r <= 1'b1;	
			end
			MEM_WRITE:
			begin
				if(app_rdy)
				begin
					app_addr_r <= app_addr_r + 'b1000;
					if(wr_addr_cnt == wr_burst_len - 1)
					begin
						app_wdf_end_r <= 1'b0;
						app_en_r <= 1'b0;
					end
					else
					begin
						wr_addr_cnt <= wr_addr_cnt + 1;
					end
				end
					
				if(wr_burst_data_req)
				begin
					
					if(wr_data_cnt == wr_burst_len - 1)
					begin
						//app_wdf_wren_r <= 1'b0;	
						state <= MEM_WRITE_WAIT;
						//wr_burst_data_req_r <= 1'b0;
					end
					else
					begin
						//wr_burst_data_req_r <= 1'b1;
						wr_data_cnt <= wr_data_cnt + 1;
					end
				end
				
			end
			READ_END:
				state <= IDLE;
			MEM_WRITE_WAIT:
			begin
				if(app_rdy)
				begin
					app_addr_r <= app_addr_r + 'b1000;
					if(wr_addr_cnt == wr_burst_len - 1)
					begin
						app_wdf_end_r <= 1'b0;
						app_en_r <= 1'b0;
						if(app_wdf_rdy) 
							state <= WRITE_END;
					end
					else
					begin
						wr_addr_cnt <= wr_addr_cnt + 1;
					end
				end
				else if(~app_en_r & app_wdf_rdy)
					state <= WRITE_END;
				
			end
			WRITE_END:
				state <= IDLE;
			default:
				state <= IDLE;
		endcase
	end
end
endmodule 