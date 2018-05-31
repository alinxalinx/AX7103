`timescale 1ns/1ps
module mv_pattern0
(
	input            clk           ,
	input            rst           ,
	input [15: 0]    hactive       ,
	input [15: 0]    vactive       ,
	input            timing_hs     ,
	input            timing_vs     ,
	input            timing_de     ,
	input [11: 0]    timing_x      ,
	input [11: 0]    timing_y      ,
	output           hs            , 
	output           vs            , 
	output           de            , 
	output[ 7: 0]    rgb_r         ,
	output[ 7: 0]    rgb_g         ,
	output[ 7: 0]    rgb_b     	
);
parameter WHITE_R 		= 8'hff;
parameter WHITE_G 		= 8'hff;
parameter WHITE_B 		= 8'hff;
parameter YELLOW_R 		= 8'hff;
parameter YELLOW_G 		= 8'hff;
parameter YELLOW_B 		= 8'h00;                              	
parameter CYAN_R 		= 8'h00;
parameter CYAN_G 		= 8'hff;
parameter CYAN_B 		= 8'hff;                             	
parameter GREEN_R 		= 8'h00;
parameter GREEN_G 		= 8'hff;
parameter GREEN_B 		= 8'h00;
parameter MAGENTA_R 	= 8'hff;
parameter MAGENTA_G 	= 8'h00;
parameter MAGENTA_B 	= 8'hff;
parameter RED_R 		= 8'hff;
parameter RED_G 		= 8'h00;
parameter RED_B 		= 8'h00;
parameter BLUE_R 		= 8'h00;
parameter BLUE_G 		= 8'h00;
parameter BLUE_B 		= 8'hff;
parameter BLACK_R 		= 8'h00;
parameter BLACK_G 		= 8'h00;
parameter BLACK_B 		= 8'h00;

wire[15: 0] h_bound_width;
reg [15: 0] h_bound_1st;
reg [15: 0] h_bound_2nd;
reg [15: 0] h_bound_3rd;
reg [15: 0] h_bound_4th;
reg [15: 0] h_bound_5th;
reg [15: 0] h_bound_6th;
reg [15: 0] h_bound_7th;
reg [15: 0] h_bound_8th;
reg[7:0] rgb_r_out;
reg[7:0] rgb_g_out;
reg[7:0] rgb_b_out;
reg timing_hs_d0;
reg timing_vs_d0;
reg timing_de_d0;
assign h_bound_width = {3'd0,hactive[15:3]};
assign rgb_r = rgb_r_out;
assign rgb_g = rgb_g_out;
assign rgb_b = rgb_b_out;
assign hs = timing_hs_d0;
assign vs = timing_vs_d0;
assign de = timing_de_d0;
always@(posedge clk or posedge rst)
begin
	if(rst)
		timing_hs_d0 <= 1'b0;
	else
		timing_hs_d0 <= timing_hs;
end
always@(posedge clk or posedge rst)
begin
	if(rst)
		timing_vs_d0 <= 1'b0;
	else
		timing_vs_d0 <= timing_vs;
end
always@(posedge clk or posedge rst)
begin
	if(rst)
		timing_de_d0 <= 1'b0;
	else
		timing_de_d0 <= timing_de;
end
always@(posedge clk or posedge rst)
begin
	if(rst)
		h_bound_1st <= 16'd0;
	else
		h_bound_1st <= 16'd0;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		h_bound_2nd <= 16'd0;
	else
		h_bound_2nd <= h_bound_1st + h_bound_width - 16'd1;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		h_bound_3rd <= 16'd0;
	else
		h_bound_3rd <= h_bound_2nd + h_bound_width;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		h_bound_4th <= 16'd0;
	else
		h_bound_4th <= h_bound_3rd + h_bound_width;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		h_bound_5th <= 16'd0;
	else
		h_bound_5th <= h_bound_4th + h_bound_width;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		h_bound_6th <= 16'd0;
	else
		h_bound_6th <= h_bound_5th + h_bound_width;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		h_bound_7th <= 16'd0;
	else
		h_bound_7th <= h_bound_6th + h_bound_width;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		h_bound_8th <= 16'd0;
	else
		h_bound_8th <= h_bound_7th + h_bound_width;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		begin
			rgb_r_out <= 8'd0;
			rgb_g_out <= 8'd0;
			rgb_b_out <= 8'd0;
		end
	else if(timing_de)
		case(timing_x)
			h_bound_1st:
				begin
					rgb_r_out <= WHITE_R;
					rgb_g_out <= WHITE_G;
					rgb_b_out <= WHITE_B;
				end
			h_bound_2nd:
				begin
					rgb_r_out <= YELLOW_R;
					rgb_g_out <= YELLOW_G;
					rgb_b_out <= YELLOW_B;
				end
			h_bound_3rd:	
				begin
					rgb_r_out <= CYAN_R;
					rgb_g_out <= CYAN_G;
					rgb_b_out <= CYAN_B;
				end			
			h_bound_4th:
				begin
					rgb_r_out <= GREEN_R;
					rgb_g_out <= GREEN_G;
					rgb_b_out <= GREEN_B;
				end			
			h_bound_5th:
				begin
					rgb_r_out <= MAGENTA_R;
					rgb_g_out <= MAGENTA_G;
					rgb_b_out <= MAGENTA_B;
				end			
			h_bound_6th:
				begin
					rgb_r_out <= RED_R;
					rgb_g_out <= RED_G;
					rgb_b_out <= RED_B;
				end			
			h_bound_7th:
				begin
					rgb_r_out <= BLUE_R;
					rgb_g_out <= BLUE_G;
					rgb_b_out <= BLUE_B;
				end			
			h_bound_8th:
				begin
					rgb_r_out <= BLACK_R;
					rgb_g_out <= BLACK_G;
					rgb_b_out <= BLACK_B;
				end			
			default:
				begin
					rgb_r_out <= rgb_r_out;
					rgb_g_out <= rgb_g_out;
					rgb_b_out <= rgb_b_out;
				end				
		endcase
	else
		begin
			rgb_r_out <= 8'd0;
			rgb_g_out <= 8'd0;
			rgb_b_out <= 8'd0;
		end		
end
endmodule 