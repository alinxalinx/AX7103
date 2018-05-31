module mv_pattern
(
	input         clk                     ,
	input         rst                     ,
	input [3:0  ] mode                    ,
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
	output        hs                      ,            
	output        vs                      ,            
	output        de                      ,            
	output[7:0]   rgb_r                   ,    
	output[7:0]   rgb_g                   ,    
	output[7:0]   rgb_b     	
);
wire timing_de;
wire timing_hs;
wire timing_vs;
wire[11:0] timing_x;
wire[11:0] timing_y;
reg[15:0] hactive;
reg[15:0] vactive;

reg      pattern_hs;   
reg      pattern_vs;   
reg      pattern_de;   
reg[7:0] pattern_rgb_r;
reg[7:0] pattern_rgb_g;
reg[7:0] pattern_rgb_b;

wire      pattern0_hs;   
wire      pattern0_vs;   
wire      pattern0_de;   
wire[7:0] pattern0_rgb_r;
wire[7:0] pattern0_rgb_g;
wire[7:0] pattern0_rgb_b;

wire      pattern1_hs;   
wire      pattern1_vs;   
wire      pattern1_de;   
wire[7:0] pattern1_rgb_r;
wire[7:0] pattern1_rgb_g;
wire[7:0] pattern1_rgb_b;

wire      pattern2_hs;   
wire      pattern2_vs;   
wire      pattern2_de;   
wire[7:0] pattern2_rgb_r;
wire[7:0] pattern2_rgb_g;
wire[7:0] pattern2_rgb_b;

wire      pattern3_hs;   
wire      pattern3_vs;   
wire      pattern3_de;   
wire[7:0] pattern3_rgb_r;
wire[7:0] pattern3_rgb_g;
wire[7:0] pattern3_rgb_b;

wire      pattern4_hs;   
wire      pattern4_vs;   
wire      pattern4_de;   
wire[7:0] pattern4_rgb_r;
wire[7:0] pattern4_rgb_g;
wire[7:0] pattern4_rgb_b;

wire      pattern5_hs;   
wire      pattern5_vs;   
wire      pattern5_de;   
wire[7:0] pattern5_rgb_r;
wire[7:0] pattern5_rgb_g;
wire[7:0] pattern5_rgb_b;

wire      pattern6_hs;   
wire      pattern6_vs;   
wire      pattern6_de;   
wire[7:0] pattern6_rgb_r;
wire[7:0] pattern6_rgb_g;
wire[7:0] pattern6_rgb_b;

assign hs         =    pattern_hs;             
assign vs         =    pattern_vs;             
assign de         =    pattern_de;             
assign rgb_r      =    pattern_rgb_r;  
assign rgb_g      =    pattern_rgb_g;  
assign rgb_b      =    pattern_rgb_b;

always@(posedge clk or posedge rst)
begin
	if(rst)
		hactive <= 16'd0;
	else
		hactive <= hactive_end - hactive_start;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
		vactive <= 16'd0;
	else
		vactive <= vactive_end - vactive_start;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
	begin
		pattern_hs    <= 1'b0;   
		pattern_vs    <= 1'b0;   
		pattern_de    <= 1'b0;   
		pattern_rgb_r <= 8'd0;
		pattern_rgb_g <= 8'd0;
		pattern_rgb_b <= 8'd0;
	end
	else
	begin
		case(mode)
			4'd0:
			begin
				pattern_hs    <= pattern0_hs   ;
				pattern_vs    <= pattern0_vs   ;
				pattern_de    <= pattern0_de   ;
				pattern_rgb_r <= pattern0_rgb_r;
				pattern_rgb_g <= pattern0_rgb_g;
				pattern_rgb_b <= pattern0_rgb_b;
			end
			4'd1:
			begin
				pattern_hs    <= pattern1_hs   ;
				pattern_vs    <= pattern1_vs   ;
				pattern_de    <= pattern1_de   ;
				pattern_rgb_r <= pattern1_rgb_r;
				pattern_rgb_g <= pattern1_rgb_g;
				pattern_rgb_b <= pattern1_rgb_b;
			end
			4'd2:
			begin
				pattern_hs    <= pattern2_hs   ;
				pattern_vs    <= pattern2_vs   ;
				pattern_de    <= pattern2_de   ;
				pattern_rgb_r <= pattern2_rgb_r;
				pattern_rgb_g <= pattern2_rgb_g;
				pattern_rgb_b <= pattern2_rgb_b;
			end
			4'd3:
			begin
				pattern_hs    <= pattern3_hs   ;
				pattern_vs    <= pattern3_vs   ;
				pattern_de    <= pattern3_de   ;
				pattern_rgb_r <= pattern3_rgb_r;
				pattern_rgb_g <= pattern3_rgb_g;
				pattern_rgb_b <= pattern3_rgb_b;
			end
			4'd4:
			begin
				pattern_hs    <= pattern4_hs   ;
				pattern_vs    <= pattern4_vs   ;
				pattern_de    <= pattern4_de   ;
				pattern_rgb_r <= pattern4_rgb_r;
				pattern_rgb_g <= pattern4_rgb_g;
				pattern_rgb_b <= pattern4_rgb_b;
			end
			4'd5:
			begin
				pattern_hs    <= pattern5_hs   ;
				pattern_vs    <= pattern5_vs   ;
				pattern_de    <= pattern5_de   ;
				pattern_rgb_r <= pattern5_rgb_r;
				pattern_rgb_g <= pattern5_rgb_g;
				pattern_rgb_b <= pattern5_rgb_b;
			end	
			4'd6:
			begin
				pattern_hs    <= pattern6_hs   ;
				pattern_vs    <= pattern6_vs   ;
				pattern_de    <= pattern6_de   ;
				pattern_rgb_r <= pattern6_rgb_r;
				pattern_rgb_g <= pattern6_rgb_g;
				pattern_rgb_b <= pattern6_rgb_b;
			end				
			default:
			begin
				pattern_hs    <= pattern0_hs   ;
				pattern_vs    <= pattern0_vs   ;
				pattern_de    <= pattern0_de   ;
				pattern_rgb_r <= pattern0_rgb_r;
				pattern_rgb_g <= pattern0_rgb_g;
				pattern_rgb_b <= pattern0_rgb_b;
			end			
		endcase
	end
end

mv_video_timing mv_video_timing_m0
(
	.clk            ( clk             ),
	.rst            ( rst             ),
	.positive_hsync ( positive_hsync  ),
	.positive_vsync ( positive_vsync  ),
	.htotal_size    ( htotal_size     ),
	.hactive_start  ( hactive_start   ),
	.hactive_end    ( hactive_end     ),
	.hsync_start    ( hsync_start     ),
	.hsync_end      ( hsync_end       ),
	.vtotal_size    ( vtotal_size     ),
	.vactive_start  ( vactive_start   ),
	.vactive_end    ( vactive_end     ),
	.vsync_start    ( vsync_start     ),
	.vsync_end      ( vsync_end       ),
	.de             ( timing_de       ),
	.hs             ( timing_hs       ),
	.vs             ( timing_vs       )
);

mv_timing_xy mv_timing_xy_m0(
	.rst       (rst       ),
	.clk       (clk       ),
	.i_vs      (timing_vs ),
	.i_de      (timing_de ),
	.timing_x  (timing_x  ),
	.timing_y  (timing_y  )
);

mv_pattern0 mv_pattern0_m0
(
	.clk           (clk              ), 
	.rst           (rst              ), 
	.hactive       (hactive          ), 
	.vactive       (vactive          ), 
	.timing_hs     (timing_hs        ), 
	.timing_vs     (timing_vs        ), 
	.timing_de     (timing_de        ), 
	.timing_x      (timing_x         ), 
	.timing_y      (timing_y         ), 
	.hs            (pattern0_hs      ), 
	.vs            (pattern0_vs      ), 
	.de            (pattern0_de      ), 
	.rgb_r         (pattern0_rgb_r   ), 
	.rgb_g         (pattern0_rgb_g   ), 
	.rgb_b     	   (pattern0_rgb_b   )
);

mv_pattern1 mv_pattern1_m0
(
	.clk           (clk              ), 
	.rst           (rst              ), 
	.hactive       (hactive          ), 
	.vactive       (vactive          ), 
	.timing_hs     (timing_hs        ), 
	.timing_vs     (timing_vs        ), 
	.timing_de     (timing_de        ), 
	.timing_x      (timing_x         ), 
	.timing_y      (timing_y         ), 
	.hs            (pattern1_hs      ), 
	.vs            (pattern1_vs      ), 
	.de            (pattern1_de      ), 
	.rgb_r         (pattern1_rgb_r   ), 
	.rgb_g         (pattern1_rgb_g   ), 
	.rgb_b     	   (pattern1_rgb_b   )
);

mv_pattern2 mv_pattern2_m0
(
	.clk           (clk              ), 
	.rst           (rst              ), 
	.hactive       (hactive          ), 
	.vactive       (vactive          ), 
	.timing_hs     (timing_hs        ), 
	.timing_vs     (timing_vs        ), 
	.timing_de     (timing_de        ), 
	.timing_x      (timing_x         ), 
	.timing_y      (timing_y         ), 
	.hs            (pattern2_hs      ), 
	.vs            (pattern2_vs      ), 
	.de            (pattern2_de      ), 
	.rgb_r         (pattern2_rgb_r   ), 
	.rgb_g         (pattern2_rgb_g   ), 
	.rgb_b     	   (pattern2_rgb_b   )
);

mv_pattern3 mv_pattern3_m0
(
	.clk           (clk              ), 
	.rst           (rst              ), 
	.hactive       (hactive          ), 
	.vactive       (vactive          ), 
	.timing_hs     (timing_hs        ), 
	.timing_vs     (timing_vs        ), 
	.timing_de     (timing_de        ), 
	.timing_x      (timing_x         ), 
	.timing_y      (timing_y         ), 
	.hs            (pattern3_hs      ), 
	.vs            (pattern3_vs      ), 
	.de            (pattern3_de      ), 
	.rgb_r         (pattern3_rgb_r   ), 
	.rgb_g         (pattern3_rgb_g   ), 
	.rgb_b     	   (pattern3_rgb_b   )
);

mv_pattern4 mv_pattern4_m0
(
	.clk           (clk              ), 
	.rst           (rst              ), 
	.hactive       (hactive          ), 
	.vactive       (vactive          ), 
	.timing_hs     (timing_hs        ), 
	.timing_vs     (timing_vs        ), 
	.timing_de     (timing_de        ), 
	.timing_x      (timing_x         ), 
	.timing_y      (timing_y         ), 
	.hs            (pattern4_hs      ), 
	.vs            (pattern4_vs      ), 
	.de            (pattern4_de      ), 
	.rgb_r         (pattern4_rgb_r   ), 
	.rgb_g         (pattern4_rgb_g   ), 
	.rgb_b     	   (pattern4_rgb_b   )
);

mv_pattern5 mv_pattern5_m0
(
	.clk           (clk              ), 
	.rst           (rst              ), 
	.hactive       (hactive          ), 
	.vactive       (vactive          ), 
	.timing_hs     (timing_hs        ), 
	.timing_vs     (timing_vs        ), 
	.timing_de     (timing_de        ), 
	.timing_x      (timing_x         ), 
	.timing_y      (timing_y         ), 
	.hs            (pattern5_hs      ), 
	.vs            (pattern5_vs      ), 
	.de            (pattern5_de      ), 
	.rgb_r         (pattern5_rgb_r   ), 
	.rgb_g         (pattern5_rgb_g   ), 
	.rgb_b     	   (pattern5_rgb_b   )
);

mv_pattern6 mv_pattern6_m0
(
	.clk           (clk              ), 
	.rst           (rst              ), 
	.hactive       (hactive          ), 
	.vactive       (vactive          ), 
	.timing_hs     (timing_hs        ), 
	.timing_vs     (timing_vs        ), 
	.timing_de     (timing_de        ), 
	.timing_x      (timing_x         ), 
	.timing_y      (timing_y         ), 
	.hs            (pattern6_hs      ), 
	.vs            (pattern6_vs      ), 
	.de            (pattern6_de      ), 
	.rgb_r         (pattern6_rgb_r   ), 
	.rgb_g         (pattern6_rgb_g   ), 
	.rgb_b     	   (pattern6_rgb_b   )
);
endmodule 