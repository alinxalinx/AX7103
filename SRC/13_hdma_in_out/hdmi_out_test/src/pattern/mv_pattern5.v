module mv_pattern5
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

wire[15: 0] v_bound_width;
reg [15: 0] v_bound_1st;
reg [15: 0] v_bound_2nd;
reg [15: 0] v_bound_3rd;
reg [15: 0] v_bound_4th;
reg [15: 0] v_bound_5th;
reg [15: 0] v_bound_6th;
reg [15: 0] v_bound_7th;
reg [15: 0] v_bound_8th;
reg[7:0] rgb_r_out;
reg[7:0] rgb_g_out;
reg[7:0] rgb_b_out;
reg timing_hs_d0;
reg timing_vs_d0;
reg timing_de_d0;
reg[2:0] v_bound;
assign v_bound_width = 16'd256;
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
		v_bound_1st <= 16'd0;
	else
		v_bound_1st <= 16'd0;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		v_bound_2nd <= 16'd0;
	else
		v_bound_2nd <= v_bound_1st + v_bound_width - 16'd1;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		v_bound_3rd <= 16'd0;
	else
		v_bound_3rd <= v_bound_2nd + v_bound_width;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		v_bound_4th <= 16'd0;
	else
		v_bound_4th <= v_bound_3rd + v_bound_width;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		v_bound_5th <= 16'd0;
	else
		v_bound_5th <= v_bound_4th + v_bound_width;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		v_bound_6th <= 16'd0;
	else
		v_bound_6th <= v_bound_5th + v_bound_width;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		v_bound_7th <= 16'd0;
	else
		v_bound_7th <= v_bound_6th + v_bound_width;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		v_bound_8th <= 16'd0;
	else
		v_bound_8th <= v_bound_7th + v_bound_width;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		v_bound <= 3'd0;
	else
		case(timing_y)
			v_bound_1st:
				v_bound <= 3'd0;
			v_bound_2nd:
				v_bound <= 3'd1;
			v_bound_3rd:	
				v_bound <= 3'd2;			
			v_bound_4th:
				v_bound <= 3'd3;			
			v_bound_5th:
				v_bound <= 3'd4;			
			v_bound_6th:
				v_bound <= 3'd5;			
			v_bound_7th:
				v_bound <= 3'd6;			
			v_bound_8th:
				v_bound <= 3'd7;			
			default:
				v_bound <= v_bound;				
		endcase
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
		case(v_bound)
			3'd0:
				begin
					rgb_r_out <= 8'hff;
					rgb_g_out <= timing_y[7:0];
					rgb_b_out <= timing_y[7:0];
				end
			3'd1:
				begin
					rgb_r_out <= timing_y[7:0];
					rgb_g_out <= 8'hff;
					rgb_b_out <= timing_y[7:0];
				end
			3'd2:	
				begin
					rgb_r_out <= timing_y[7:0];
					rgb_g_out <= timing_y[7:0];
					rgb_b_out <= 8'hff;
				end			
			3'd3:
				begin
					rgb_r_out <= 8'd255;
					rgb_g_out <= timing_y[7:0];
					rgb_b_out <= 8'd255;
				end			
			3'd4:
				begin
					rgb_r_out <= 8'd0;
					rgb_g_out <= 8'd0;
					rgb_b_out <= timing_y[7:0];
				end			
			3'd5:
				begin
					rgb_r_out <= 8'd255;
					rgb_g_out <= 8'd255;
					rgb_b_out <= timing_y[7:0];
				end			
			3'd6:
				begin
					rgb_r_out <= timing_y[7:0];
					rgb_g_out <= timing_y[7:0];
					rgb_b_out <= timing_y[7:0];
				end			
			3'd7:
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