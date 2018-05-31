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
module mem_write_arbi
#(
	parameter MEM_DATA_BITS = 32,
	parameter ADDR_BITS              = 23,
    parameter BUSRT_BITS             = 10
)
(
	input rst_n,
	input mem_clk,
	
	input ch0_wr_burst_req,
	input[BUSRT_BITS - 1:0] ch0_wr_burst_len,
	input[ADDR_BITS - 1:0] ch0_wr_burst_addr,
	output ch0_wr_burst_data_req,
	input[MEM_DATA_BITS - 1:0] ch0_wr_burst_data,
	output ch0_wr_burst_finish,
	
	input ch1_wr_burst_req,
	input[BUSRT_BITS - 1:0] ch1_wr_burst_len,
	input[ADDR_BITS - 1:0] ch1_wr_burst_addr,
	output ch1_wr_burst_data_req,
	input[MEM_DATA_BITS - 1:0] ch1_wr_burst_data,
	output ch1_wr_burst_finish,
	
	input ch2_wr_burst_req,
	input[BUSRT_BITS - 1:0] ch2_wr_burst_len,
	input[ADDR_BITS - 1:0] ch2_wr_burst_addr,
	output ch2_wr_burst_data_req,
	input[MEM_DATA_BITS - 1:0] ch2_wr_burst_data,
	output ch2_wr_burst_finish,
	
	input ch3_wr_burst_req,
	input[BUSRT_BITS - 1:0] ch3_wr_burst_len,
	input[ADDR_BITS - 1:0] ch3_wr_burst_addr,
	output ch3_wr_burst_data_req,
	input[MEM_DATA_BITS - 1:0] ch3_wr_burst_data,
	output ch3_wr_burst_finish,
	
	output reg wr_burst_req,
	output reg[BUSRT_BITS - 1:0] wr_burst_len,
	output reg[ADDR_BITS - 1:0] wr_burst_addr,
	input wr_burst_data_req,
	output reg[MEM_DATA_BITS - 1:0] wr_burst_data,
	input wr_burst_finish	
);

reg[5:0] write_state = 6'd0;
reg[5:0] write_state_next = 6'd0;
reg[15:0] cnt_timer = 16'd0;
localparam IDLE = 6'd0;

localparam CH0_CHECK = 6'd1;
localparam CH0_BEGIN = 6'd2;
localparam CH0_WRITE = 6'd3;
localparam CH0_END = 6'd4;

localparam CH1_CHECK = 6'd5;
localparam CH1_BEGIN = 6'd6;
localparam CH1_WRITE = 6'd7;
localparam CH1_END = 6'd8;

localparam CH2_CHECK = 6'd9;
localparam CH2_BEGIN = 6'd10;
localparam CH2_WRITE = 6'd11;
localparam CH2_END = 6'd12;

localparam CH3_CHECK = 6'd13;
localparam CH3_BEGIN = 6'd14;
localparam CH3_WRITE = 6'd15;
localparam CH3_END = 6'd16;

reg wr_burst_finish_d0;
reg wr_burst_finish_d1;
always@(posedge mem_clk)
begin
	wr_burst_finish_d0 <= wr_burst_finish;
	wr_burst_finish_d1 <= wr_burst_finish_d0;
end

always@(posedge mem_clk or negedge rst_n)
begin
	if(~rst_n)
		write_state <= IDLE;
	else if(cnt_timer > 16'd8000)
		write_state <= IDLE;
	else
		write_state <= write_state_next;
end

always@(posedge mem_clk or negedge rst_n)
begin
	if(~rst_n)
		cnt_timer <= 16'd0;
	else if(write_state == CH0_CHECK)
		cnt_timer <= 16'd0;
	else
		cnt_timer <= cnt_timer + 16'd1;
end

always@(*)
begin
	case(write_state)
		IDLE:
			write_state_next <= CH0_CHECK;
		//
		CH0_CHECK:
			if(ch0_wr_burst_req  && ch0_wr_burst_len != {BUSRT_BITS{1'd0}})
				write_state_next <= CH0_BEGIN;
			else
				write_state_next <= CH1_CHECK;
		CH0_BEGIN:
			write_state_next <= CH0_WRITE;
		CH0_WRITE:
			if(wr_burst_finish_d1)
				write_state_next <= CH0_END;
			else
				write_state_next <= CH0_WRITE;
		CH0_END:
			write_state_next <= CH1_CHECK;
		//	
		CH1_CHECK:
			if(ch1_wr_burst_req && ch1_wr_burst_len != {BUSRT_BITS{1'd0}})
				write_state_next <= CH1_BEGIN;
			else
				write_state_next <= CH2_CHECK;
		CH1_BEGIN:
			write_state_next <= CH1_WRITE;
		CH1_WRITE:
			if(wr_burst_finish_d1)
				write_state_next <= CH1_END;
			else
				write_state_next <= CH1_WRITE;
		CH1_END:
			write_state_next <= CH2_CHECK;
		//	
		CH2_CHECK:
			if(ch2_wr_burst_req && ch2_wr_burst_len != {BUSRT_BITS{1'd0}})
				write_state_next <= CH2_BEGIN;
			else
				write_state_next <= CH3_CHECK;
		CH2_BEGIN:
			write_state_next <= CH2_WRITE;
		CH2_WRITE:
			if(wr_burst_finish_d1)
				write_state_next <= CH2_END;
			else
				write_state_next <= CH2_WRITE;
		CH2_END:
			write_state_next <= CH3_CHECK;
		//	
		CH3_CHECK:
			if(ch3_wr_burst_req && ch3_wr_burst_len != {BUSRT_BITS{1'd0}})
				write_state_next <= CH3_BEGIN;
			else
				write_state_next <= CH0_CHECK;
		CH3_BEGIN:
			write_state_next <= CH3_WRITE;
		CH3_WRITE:
			if(wr_burst_finish_d1)
				write_state_next <= CH3_END;
			else
				write_state_next <= CH3_WRITE;
		CH3_END:
			write_state_next <= CH0_CHECK;
		default:
			write_state_next <= IDLE;
	endcase
end

always@(posedge mem_clk or negedge rst_n)
begin
	if(~rst_n)
		begin
			wr_burst_len <= {BUSRT_BITS{1'd0}};
			wr_burst_addr <= {ADDR_BITS{1'd0}};
		end
	else
		begin
			case(write_state)
				CH0_BEGIN:
					begin
						wr_burst_len <= ch0_wr_burst_len;
						wr_burst_addr <= ch0_wr_burst_addr;
					end
				CH1_BEGIN:
					begin
						wr_burst_len <= ch1_wr_burst_len;
						wr_burst_addr <= ch1_wr_burst_addr;
					end
				CH2_BEGIN:
					begin
						wr_burst_len <= ch2_wr_burst_len;
						wr_burst_addr <= ch2_wr_burst_addr;
					end
				CH3_BEGIN:
					begin
						wr_burst_len <= ch3_wr_burst_len;
						wr_burst_addr <= ch3_wr_burst_addr;
					end				
				default:
					begin
						wr_burst_len <= wr_burst_len;
						wr_burst_addr <= wr_burst_addr;
					end
			endcase
		end
end

always@(posedge mem_clk or negedge rst_n)
begin
	if(~rst_n)
		wr_burst_req <= 1'b0;
	else if(write_state == CH0_BEGIN || write_state == CH1_BEGIN || write_state == CH2_BEGIN || write_state == CH3_BEGIN)
		wr_burst_req <= 1'b1;
	else if(wr_burst_data_req)
		wr_burst_req <= 1'b0;
	else
		wr_burst_req <= wr_burst_req;
end
always@(*)
begin
	case(write_state)
		CH0_WRITE:
			wr_burst_data <= ch0_wr_burst_data;
		CH1_WRITE:
			wr_burst_data <= ch1_wr_burst_data;
		CH2_WRITE:
			wr_burst_data <= ch2_wr_burst_data;
		CH3_WRITE:
			wr_burst_data <= ch3_wr_burst_data;	
		default:
			wr_burst_data <= {MEM_DATA_BITS{1'd0}};
	endcase
end

assign ch0_wr_burst_finish = (write_state == CH0_END);
assign ch1_wr_burst_finish = (write_state == CH1_END);
assign ch2_wr_burst_finish = (write_state == CH2_END);
assign ch3_wr_burst_finish = (write_state == CH3_END);


assign ch0_wr_burst_data_req = (write_state == CH0_WRITE) ? wr_burst_data_req : 1'b0;
assign ch1_wr_burst_data_req = (write_state == CH1_WRITE) ? wr_burst_data_req : 1'b0;
assign ch2_wr_burst_data_req = (write_state == CH2_WRITE) ? wr_burst_data_req : 1'b0;
assign ch3_wr_burst_data_req = (write_state == CH3_WRITE) ? wr_burst_data_req : 1'b0;


endmodule 