//////////////////////////////////////////////////////////////////////////////////
//                                                                              //
//                                                                              //
//  Author: meisq                                                               //
//          msq@qq.com                                                          //
//          ALINX(shanghai) Technology Co.,Ltd                                  //
//          heijin                                                              //
//     WEB: http://www.alinx.cn/                                                //
//     BBS: http://www.heijin.org/                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
//                                                                              //
// Copyright (c) 2017,ALINX(shanghai) Technology Co.,Ltd                        //
//                    All rights reserved                                       //
//                                                                              //
// This source file may be used and distributed without restriction provided    //
// that this copyright statement is not removed from the file and that any      //
// derivative work contains the original copyright notice and the associated    //
// disclaimer.                                                                  //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

//================================================================================
//  Revision History:
//  Date          By            Revision    Change Description
//--------------------------------------------------------------------------------
//  2017/9/14     meisq          1.0         Original
//*******************************************************************************/
module mem_read_arbi
#(
	parameter MEM_DATA_BITS          = 32,
	parameter ADDR_BITS              = 23,
	parameter BUSRT_BITS             = 10
)
(
	input rst_n,
	input mem_clk,
	input ch0_rd_burst_req,
	input[BUSRT_BITS - 1:0] ch0_rd_burst_len,
	input[ADDR_BITS - 1:0] ch0_rd_burst_addr,
	output ch0_rd_burst_data_valid,
	output[MEM_DATA_BITS - 1:0] ch0_rd_burst_data,
	output ch0_rd_burst_finish,
	
	input ch1_rd_burst_req,
	input[BUSRT_BITS - 1:0] ch1_rd_burst_len,
	input[ADDR_BITS - 1:0] ch1_rd_burst_addr,
	output ch1_rd_burst_data_valid,
	output[MEM_DATA_BITS - 1:0] ch1_rd_burst_data,
	output ch1_rd_burst_finish,
	
	input ch2_rd_burst_req,
	input[BUSRT_BITS - 1:0] ch2_rd_burst_len,
	input[ADDR_BITS - 1:0] ch2_rd_burst_addr,
	output ch2_rd_burst_data_valid,
	output[MEM_DATA_BITS - 1:0] ch2_rd_burst_data,
	output ch2_rd_burst_finish,
	
	input ch3_rd_burst_req,
	input[BUSRT_BITS - 1:0] ch3_rd_burst_len,
	input[ADDR_BITS - 1:0] ch3_rd_burst_addr,
	output ch3_rd_burst_data_valid,
	output[MEM_DATA_BITS - 1:0] ch3_rd_burst_data,
	output ch3_rd_burst_finish,
	///////////////////////////////////////////
	output reg rd_burst_req,
	output reg[BUSRT_BITS - 1:0] rd_burst_len,
	output reg[ADDR_BITS - 1:0] rd_burst_addr,
	input rd_burst_data_valid,
	input[MEM_DATA_BITS - 1:0] rd_burst_data,
	input rd_burst_finish	
);

reg[5:0] read_state = 6'd0;
reg[5:0] read_state_next = 6'd0;
reg[15:0] cnt_timer = 15'd0;
localparam IDLE = 6'd0;

localparam CH0_CHECK = 6'd1;
localparam CH0_BEGIN = 6'd2;
localparam CH0_READ = 6'd3;
localparam CH0_END = 6'd4;

localparam CH1_CHECK = 6'd5;
localparam CH1_BEGIN = 6'd6;
localparam CH1_READ = 6'd7;
localparam CH1_END = 6'd8;

localparam CH2_CHECK = 6'd9;
localparam CH2_BEGIN = 6'd10;
localparam CH2_READ = 6'd11;
localparam CH2_END = 6'd12;

localparam CH3_CHECK = 6'd13;
localparam CH3_BEGIN = 6'd14;
localparam CH3_READ = 6'd15;
localparam CH3_END = 6'd16;


always@(posedge mem_clk or negedge rst_n)
begin
	if(~rst_n)
		read_state <= IDLE;
	else if(cnt_timer > 16'd8000)
		read_state <= IDLE;
	else
		read_state <= read_state_next;
end

always@(posedge mem_clk or negedge rst_n)
begin
	if(~rst_n)
		cnt_timer <= 16'd0;
	else if(read_state == CH0_CHECK)
		cnt_timer <= 16'd0;
	else
		cnt_timer <= cnt_timer + 16'd1;
end

always@(*)
begin
	case(read_state)
		IDLE:
			read_state_next <= CH0_CHECK;
		//
		CH0_CHECK:
			if(ch0_rd_burst_req && ch0_rd_burst_len != {BUSRT_BITS{1'd0}})
				read_state_next <= CH0_BEGIN;
			else
				read_state_next <= CH1_CHECK;
		CH0_BEGIN:
			read_state_next <= CH0_READ;
		CH0_READ:
			if(rd_burst_finish)
				read_state_next <= CH0_END;
			else
				read_state_next <= CH0_READ;
		CH0_END:
			read_state_next <= CH1_CHECK;
		//	
		CH1_CHECK:
			if(ch1_rd_burst_req && ch1_rd_burst_len != {BUSRT_BITS{1'd0}})
				read_state_next <= CH1_BEGIN;
			else
				read_state_next <= CH2_CHECK;
		CH1_BEGIN:
			read_state_next <= CH1_READ;
		CH1_READ:
			if(rd_burst_finish)
				read_state_next <= CH1_END;
			else
				read_state_next <= CH1_READ;
		CH1_END:
			read_state_next <= CH2_CHECK;
		//	
		CH2_CHECK:
			if(ch2_rd_burst_req  && ch2_rd_burst_len != {BUSRT_BITS{1'd0}})
				read_state_next <= CH2_BEGIN;
			else
				read_state_next <= CH3_CHECK;
		CH2_BEGIN:
			read_state_next <= CH2_READ;
		CH2_READ:
			if(rd_burst_finish)
				read_state_next <= CH2_END;
			else
				read_state_next <= CH2_READ;
		CH2_END:
			read_state_next <= CH3_CHECK;
		//	
		CH3_CHECK:
			if(ch3_rd_burst_req  && ch3_rd_burst_len != {BUSRT_BITS{1'd0}})
				read_state_next <= CH3_BEGIN;
			else
				read_state_next <= CH0_CHECK;
		CH3_BEGIN:
			read_state_next <= CH3_READ;
		CH3_READ:
			if(rd_burst_finish)
				read_state_next <= CH3_END;
			else
				read_state_next <= CH3_READ;
		CH3_END:
			read_state_next <= CH0_CHECK;		
		default:
			read_state_next <= IDLE;
	endcase
end

always@(posedge mem_clk or negedge rst_n)
begin
	if(~rst_n)
		begin
			rd_burst_len <= {BUSRT_BITS{1'd0}};
			rd_burst_addr <= {ADDR_BITS{1'd0}};
		end
	else
		begin
			case(read_state)
				CH0_BEGIN:
					begin
						rd_burst_len <= ch0_rd_burst_len;
						rd_burst_addr <= ch0_rd_burst_addr;
					end
				CH1_BEGIN:
					begin
						rd_burst_len <= ch1_rd_burst_len;
						rd_burst_addr <= ch1_rd_burst_addr;
					end
				CH2_BEGIN:
					begin
						rd_burst_len <= ch2_rd_burst_len;
						rd_burst_addr <= ch2_rd_burst_addr;
					end
				CH3_BEGIN:
					begin
						rd_burst_len <= ch3_rd_burst_len;
						rd_burst_addr <= ch3_rd_burst_addr;
					end
				default:
					begin
						rd_burst_len <= rd_burst_len;
						rd_burst_addr <= rd_burst_addr;
					end
			endcase
		end
end

always@(posedge mem_clk or negedge rst_n)
begin
	if(~rst_n)
		rd_burst_req <= 1'b0;
	else if(read_state == CH0_BEGIN || read_state == CH1_BEGIN || read_state == CH2_BEGIN || read_state == CH3_BEGIN)
		rd_burst_req <= 1'b1;
	else if(rd_burst_data_valid || read_state == CH0_CHECK  || read_state == CH1_CHECK  || read_state == CH2_CHECK  || read_state == CH3_CHECK)
		rd_burst_req <= 1'b0;
	else
		rd_burst_req <= rd_burst_req;
end

assign ch0_rd_burst_finish = (read_state == CH0_END);
assign ch1_rd_burst_finish = (read_state == CH1_END);
assign ch2_rd_burst_finish = (read_state == CH2_END);
assign ch3_rd_burst_finish = (read_state == CH3_END);

assign ch0_rd_burst_data_valid = (read_state == CH0_READ || read_state == CH0_END) ? rd_burst_data_valid : 1'b0;
assign ch1_rd_burst_data_valid = (read_state == CH1_READ || read_state == CH1_END) ? rd_burst_data_valid : 1'b0;
assign ch2_rd_burst_data_valid = (read_state == CH2_READ || read_state == CH2_END) ? rd_burst_data_valid : 1'b0;
assign ch3_rd_burst_data_valid = (read_state == CH3_READ || read_state == CH3_END) ? rd_burst_data_valid : 1'b0;

assign ch0_rd_burst_data = (read_state == CH0_READ) ? rd_burst_data : {MEM_DATA_BITS{1'd0}};
assign ch1_rd_burst_data = (read_state == CH1_READ) ? rd_burst_data : {MEM_DATA_BITS{1'd0}};
assign ch2_rd_burst_data = (read_state == CH2_READ) ? rd_burst_data : {MEM_DATA_BITS{1'd0}};
assign ch3_rd_burst_data = (read_state == CH3_READ) ? rd_burst_data : {MEM_DATA_BITS{1'd0}};
endmodule 