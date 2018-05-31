`timescale 1ns/1ps
module video_out_test
(
	input  sys_clk_p,
	input  sys_clk_n,
	input[1:0]  key,
	output[1:0] led,
	
	inout hdmi_scl,
	inout hdmi_sda,
	output hdmi_nreset,
	
	output vout_clk,
	output vout_hs,
	output vout_vs,
	output vout_de,
	output[23:0] vout_data
);
//parameter   H_ACTIVE = 16'd1280;  //行有效长度（像素时钟周期个数）
//parameter   H_FP = 16'd110;       //行同步前肩长度
//parameter   H_SYNC = 16'd40;      //行同步长度
//parameter   H_BP = 16'd220;       //行同步后肩长度
//parameter   V_ACTIVE = 16'd720;   //场有效长度（行的个数）
//parameter   V_FP 	= 16'd5;      //场同步前肩长度
//parameter   V_SYNC  = 16'd5;      //场同步长度
//parameter   V_BP	= 16'd20;     //场同步后肩长度

parameter H_ACTIVE = 16'd1920;
parameter H_FP = 16'd88;
parameter H_SYNC = 16'd44;
parameter H_BP = 16'd148; 
parameter V_ACTIVE = 16'd1080;
parameter V_FP 	= 16'd4;
parameter V_SYNC  = 16'd5;
parameter V_BP	= 16'd36;

parameter   H_TOTAL = H_ACTIVE + H_FP + H_SYNC + H_BP;//行总长度
parameter   V_TOTAL = V_ACTIVE + V_FP + V_SYNC + V_BP;//场总长度

wire      video_clk;
wire      pattern_hs;   
wire      pattern_vs;   
wire      pattern_de;   
wire[7:0] pattern_rgb_r;
wire[7:0] pattern_rgb_g;
wire[7:0] pattern_rgb_b;
reg[3:0] mode;
wire button0_negedge;
wire clk_27m;
wire rst_n;
wire locked;
assign vout_clk = video_clk;
assign vout_hs = pattern_hs;
assign vout_vs = pattern_vs;
assign vout_de = pattern_de;
assign vout_data = {pattern_rgb_r,pattern_rgb_g,pattern_rgb_b};
assign rst_n = locked;
assign hdmi_nreset = locked;
sys_pll sys_pll_i
 (
	// Clock in ports
	.clk_in1_p(sys_clk_p),
	.clk_in1_n(sys_clk_n),
	// Clock out ports
	.clk_out1(clk_27m),
	.clk_out2(video_clk),
	// Status and control signals
	.reset(1'b0),
	.locked(locked)
 );
i2c_config i2c_config_m0(
	.rst(!rst_n),
	.clk(clk_27m),
	
	.error(led[1]),
	.done(led[0]),
	
	.i2c_scl(hdmi_scl),
	.i2c_sda(hdmi_sda)
);

	
mv_debounce#
(
	.FREQ(50)
) 
mv_debounce_m0
(
	.clk(clk_27m), 
	.rst(1'b0), 
	.button_in(key[0]),
	.button_posedge(),
	.button_negedge(button0_negedge),
	.button_out()
);
always@(posedge clk_27m)
begin
	if(button0_negedge)
		mode <= (mode >= 4'd6) ? 4'd0 : mode + 4'd1;
			
end
mv_pattern mv_pattern_m0
(
	.clk            (video_clk),
	.rst            (1'b0),
	.mode           (mode),
	.positive_hsync (1'b1),
	.positive_vsync (1'b1),
	.htotal_size    (H_TOTAL - 16'd1),
	.hactive_start  (H_BP - 1),
	.hactive_end    (H_BP + H_ACTIVE - 16'd1),
	.hsync_start    (H_BP + H_ACTIVE + H_FP - 16'd1),
	.hsync_end      (H_BP + H_ACTIVE + H_FP + H_SYNC  - 16'd1),
	.vtotal_size    (V_TOTAL - 16'd1),
	.vactive_start  (V_BP - 16'd1),
	.vactive_end    (V_BP + V_ACTIVE - 16'd1),
	.vsync_start    (V_BP + V_ACTIVE + V_FP - 16'd1),
	.vsync_end      (V_BP + V_ACTIVE + V_FP + V_SYNC  - 16'd1),
	.hs             (pattern_hs      ), 
	.vs             (pattern_vs      ), 
	.de             (pattern_de      ), 
	.rgb_r          (pattern_rgb_r   ), 
	.rgb_g          (pattern_rgb_g   ), 
	.rgb_b     	    (pattern_rgb_b   )
);

endmodule 