module mv_pattern3
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
		begin
			rgb_r_out <= (timing_x[6] + timing_y[6] == 1'b1) ? 8'hff : 8'h00;
			rgb_g_out <= (timing_x[6] + timing_y[6] == 1'b1) ? 8'hff : 8'h00;
			rgb_b_out <= (timing_x[6] + timing_y[6] == 1'b1) ? 8'hff : 8'h00;
		end	
	else
		begin
			rgb_r_out <= 8'd0;
			rgb_g_out <= 8'd0;
			rgb_b_out <= 8'd0;
		end		
end
endmodule 