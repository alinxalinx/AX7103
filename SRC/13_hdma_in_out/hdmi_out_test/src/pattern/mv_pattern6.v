module mv_pattern6
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

reg[7:0] rgb_r_out;
reg[7:0] rgb_g_out;
reg[7:0] rgb_b_out;
reg timing_hs_d0;
reg timing_vs_d0;
reg timing_de_d0;
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
		begin
			rgb_r_out <= 8'd0;
			rgb_g_out <= 8'd0;
			rgb_b_out <= 8'd0;
		end
	else if(timing_de)
		if(timing_x == 16'd0 || timing_y == 16'd0 || timing_x == hactive - 16'd1 || timing_y == vactive - 16'd1)
		begin
			rgb_r_out <= WHITE_R;
			rgb_g_out <= WHITE_G;
			rgb_b_out <= WHITE_B;		
		end
		else
		begin
			rgb_r_out <= BLACK_R;
			rgb_g_out <= BLACK_G;
			rgb_b_out <= BLACK_B;		
		end		
	else
		begin
			rgb_r_out <= 8'd0;
			rgb_g_out <= 8'd0;
			rgb_b_out <= 8'd0;
		end		
end
endmodule 