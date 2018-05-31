module mv_video_timing
(
	input         clk                     ,
	input         rst                     ,
	input         positive_hsync          ,
	input         positive_vsync          ,
	input [15: 0] htotal_size             ,
	input [15: 0] hactive_start           ,
	input [15: 0] hactive_end             ,
	input [15: 0] hsync_start             ,
	input [15: 0] hsync_end               ,
	input [15: 0] vtotal_size             ,
	input [15: 0] vactive_start           ,
	input [15: 0] vactive_end             ,
	input [15: 0] vsync_start             ,
	input [15: 0] vsync_end               ,
	output        de                      ,
	output        hs                      ,
	output        vs                      
);
reg[15:0] hcnt;
reg[15:0] vcnt;
reg hactive;
reg vactive;
reg hsync_reg;
reg vsync_reg;
reg de_out;
reg hs_out;
reg vs_out;
assign de = de_out;
assign hs = hs_out;
assign vs = vs_out;

always@(posedge clk or posedge rst)
begin
	if(rst)
		hcnt <= 16'd0;
	else if(hcnt == htotal_size)
		hcnt <= 16'd0;
	else
		hcnt <= hcnt + 16'd1;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		vcnt <= 16'd0;
	else if(hcnt == hsync_start)
		if(vcnt == vtotal_size)
			vcnt <= 16'd0;
		else
			vcnt <= vcnt + 16'd1;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		hactive <= 1'b0;
	else if(hcnt == hactive_start)
		hactive <= 1'b1;
	else if(hcnt == hactive_end)
		hactive <= 1'b0;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		hsync_reg <= 1'b0;
	else if(hcnt == hsync_start)
		hsync_reg <= positive_hsync;
	else if(hcnt == hsync_end)
		hsync_reg <= ~positive_hsync;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		vsync_reg <= 1'b0;
	else if(hcnt == hsync_start && vcnt == vsync_start)
		vsync_reg <= positive_vsync;
	else if(hcnt == hsync_start && vcnt == vsync_end)
		vsync_reg <= ~positive_vsync;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		vactive <= 1'b0;
	else if(hcnt == hsync_start && vcnt == vactive_start)
		vactive <= 1'b1;
	else if(hcnt == hsync_start && vcnt == vactive_end)
		vactive <= 1'b0;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		de_out <= 1'b0;
	else 
		de_out <= hactive & vactive;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		hs_out <= 1'b0;
	else 
		hs_out <= hsync_reg;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		vs_out <= 1'b0;
	else 
		vs_out <= vsync_reg;
end

endmodule 