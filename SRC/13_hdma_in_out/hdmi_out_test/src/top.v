module top(
	//lcd output
	inout hdmi_scl,
	inout hdmi_sda,
	output hdmi_nreset,
	output hdmi_clk,
	output hdmi_hs,
	output hdmi_vs,
	output hdmi_de,
	output[23:0]  hdmi_d,
	
	
//	input rst_key,
	
	output led,
	//clock input
	input clk_125m
);
wire video_clk;
wire video_hs;
wire video_vs;
wire video_de;
wire[7:0] video_r;
wire[7:0] video_g;
wire[7:0] video_b;
wire sys_clk;
video_pll video_pll_m0
(
	// Clock in ports
	.inclk0(clk_125m),
	// Clock out ports
	.c0(sys_clk),
	.c1(video_clk)
 );
assign hdmi_clk = ~video_clk;
wire rst_n;
assign hdmi_nreset = rst_n;
reset reset_m0(
	.clk(sys_clk),
	.rst_n(rst_n)
);
wire done;
wire error;
assign led = ~(~error &  done);
i2c_config i2c_config_m0(
	.rst(!rst_n),
	.clk(sys_clk),
	
	.error(error),
	.done(done),
	
	.i2c_scl(hdmi_scl),
	.i2c_sda(hdmi_sda)
);
color_bar color_bar_inst(
	.clk(video_clk),
	.rst(1'b0),
	.hs(video_hs),
	.vs(video_vs),
	.de(video_de),
	.rgb_r(video_r),
	.rgb_g(video_g),
	.rgb_b(video_b)
);

common_std_logic_vector_delay#
(
	.WIDTH(27),
	.DELAY(1)
)
common_std_logic_vector_delay_m0
(
	.clock(video_clk),
	.reset(1'b0),
	.ena(1'b1),
	.data({video_hs,video_vs,video_de,video_r,video_g,video_b}),
	.q({hdmi_hs,hdmi_vs,hdmi_de,hdmi_d})
);


endmodule