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
//  2017/7/19     meisq          1.0         Original
//*******************************************************************************/

module video_rect_read_data
#(
	parameter DATA_WIDTH = 16                       // Video data one clock data width
)
(
	input                       video_clk,          // Video pixel clock
	input                       rst,
	input[11:0]                 video_left_offset,
	input[11:0]                 video_top_offset,
	input[11:0]                 video_width,
	input[11:0]                 video_height,
	output reg                  read_req,           // Start reading a frame of data     
	input                       read_req_ack,       // Read request response
	(*mark_debug = "true"*)output                      read_en,            // Read data enable
	input[DATA_WIDTH - 1:0]     read_data,          // Read data
	input                       timing_hs,    
	input                       timing_vs,    
	(*mark_debug = "true"*)input                       timing_de,    
	(*mark_debug = "true"*)input[DATA_WIDTH - 1:0]     timing_data, 
	output                      hs,                 // horizontal synchronization
	output                      vs,                 // vertical synchronization
	(*mark_debug = "true"*)output                      de,                 // video valid
	output[DATA_WIDTH - 1:0]    vout_data           // video data
);

(*mark_debug = "true"*)wire[11:0]             pos_x;
(*mark_debug = "true"*)wire[11:0]             pos_y;
wire                   pos_hs;
wire                   pos_vs;
(*mark_debug = "true"*)wire                   pos_de;
wire[DATA_WIDTH - 1:0] pos_data;
reg[DATA_WIDTH - 1:0]  pos_data_d0;
reg[DATA_WIDTH - 1:0]  pos_data_d1;



//delay video_hs video_vs  video_de 2 clock cycles
reg                    pos_hs_d0;
reg                    pos_vs_d0;
reg                    pos_de_d0;
reg                    pos_hs_d1;
reg                    pos_vs_d1;
reg                    pos_de_d1;
reg                    pos_hs_d2;
reg                    pos_vs_d2;
reg                    pos_de_d2;
reg                    read_en_r;
reg                    read_en_r_d0;

reg[DATA_WIDTH - 1:0]  vout_data_r;
assign hs = pos_hs_d2;
assign vs = pos_vs_d2;
assign de = pos_de_d2;

always@(posedge video_clk or posedge rst)
begin
	if(rst == 1'b1)
	begin
		pos_hs_d0 <= 1'b0;
		pos_vs_d0 <= 1'b0;
		pos_de_d0 <= 1'b0;
		pos_hs_d1 <= 1'b0;
		pos_vs_d1 <= 1'b0;
		pos_de_d1 <= 1'b0;
		pos_data_d0 <= {DATA_WIDTH{1'b0}};
		pos_data_d1 <= {DATA_WIDTH{1'b0}};
		read_en_r_d0 <= 1'b0;
	end
	else
	begin
		//delay pos hs vs de 3 clock cycles
		pos_hs_d0   <= pos_hs;
		pos_vs_d0   <= pos_vs;
		pos_de_d0   <= pos_de;
		pos_hs_d1   <= pos_hs_d0;
		pos_vs_d1   <= pos_vs_d0;
		pos_de_d1   <= pos_de_d0;	
		pos_hs_d2   <= pos_hs_d1;
		pos_vs_d2   <= pos_vs_d1;
		pos_de_d2   <= pos_de_d1;
		pos_data_d0 <= pos_data;
		pos_data_d1 <= pos_data_d0;
		read_en_r_d0 <= read_en_r;
	end
end

assign read_en = read_en_r; 
always@(posedge video_clk or posedge rst)
begin
	if(rst == 1'b1)
		read_en_r <= 1'b0;
	else if(pos_de == 1'b1 && pos_x >= video_left_offset && pos_x < video_left_offset + video_width 
	        && pos_y >= video_top_offset && pos_y < video_top_offset + video_height)
		read_en_r <= 1'b1;
	else
		read_en_r <= 1'b0;
end

assign vout_data = vout_data_r;
always@(posedge video_clk or posedge rst)
begin
	if(rst == 1'b1)
		vout_data_r <= {DATA_WIDTH{1'b0}};
	else if(read_en_r_d0 == 1'b1)
		vout_data_r <= read_data;
	else
		vout_data_r <= pos_data_d1;
end

always@(posedge video_clk or posedge rst)
begin
	if(rst == 1'b1)
		read_req <= 1'b0;
	else if(pos_vs_d0 == 1'b1 & pos_vs == 1'b0) //vertical synchronization edge (the rising or falling edges are OK)
		read_req <= 1'b1;
	else if(read_req_ack == 1'b1)
		read_req <= 1'b0;
end

timing_gen_xy#(.DATA_WIDTH(DATA_WIDTH)) timing_gen_xy_m0(
	.rst_n    (~rst          ),
	.clk      (video_clk     ),
	.i_hs     (timing_hs     ),
	.i_vs     (timing_vs     ),
	.i_de     (timing_de     ),
	.i_data   (timing_data   ),
	.o_hs     (pos_hs        ),
	.o_vs     (pos_vs        ),
	.o_de     (pos_de        ),
	.o_data   (pos_data      ),
	.x        (pos_x         ),
	.y        (pos_y         )
);
endmodule 