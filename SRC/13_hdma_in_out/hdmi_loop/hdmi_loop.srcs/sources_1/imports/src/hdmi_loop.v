`timescale 1ns/1ps
module hdmi_loop
(
	input  sys_clk_p,
	input  sys_clk_n,
	input[1:0]  key,
	
	inout hdmi_scl,
	inout hdmi_sda,
	output hdmi_nreset,
	
	output hdmi_in_nreset,
	input vin_clk,
	input vin_hs,
	input vin_vs,
	input vin_de,
	input[23:0] vin_data,
	
	output vout_clk,
	output vout_hs,
	output vout_vs,
	output vout_de,
	output[23:0] vout_data
);

wire clk_27m;
wire rst_n;
wire locked;
reg vin_hs_d0;
reg vin_vs_d0;
reg vin_de_d0;
reg[23:0] vin_data_d0;
reg vin_hs_d1;
reg vin_vs_d1;
reg vin_de_d1;
reg[23:0] vin_data_d1;
reg vin_hs_d2;
reg vin_vs_d2;
reg vin_de_d2;
reg[23:0] vin_data_d2;
assign vout_clk = vin_clk;
assign vout_hs = vin_hs_d2;
assign vout_vs = vin_vs_d2;
assign vout_de = vin_de_d2;
assign vout_data = vin_data_d2;
assign rst_n = locked;
assign hdmi_nreset = locked;
assign hdmi_in_nreset = locked;
sys_pll sys_pll_i
 (
	// Clock in ports
	.clk_in1_p(sys_clk_p),
	.clk_in1_n(sys_clk_n),
	// Clock out ports
	.clk_out1(clk_27m),
	.clk_out2(),
	// Status and control signals
	.reset(1'b0),
	.locked(locked)
 );
i2c_config i2c_config_m0(
	.rst(!rst_n),
	.clk(clk_27m),
	
	.error(),
	.done(),
	
	.i2c_scl(hdmi_scl),
	.i2c_sda(hdmi_sda)
);

always@(posedge vin_clk)
begin
    vin_hs_d0 <= vin_hs;
    vin_vs_d0 <= vin_vs;
    vin_de_d0 <= vin_de;
    vin_data_d0 <= vin_data;
    vin_hs_d1 <= vin_hs_d0;
    vin_vs_d1 <= vin_vs_d0;
    vin_de_d1 <= vin_de_d0;
    vin_data_d1 <= vin_data_d0; 
    
    vin_hs_d2 <= vin_hs_d1;
    vin_vs_d2 <= vin_vs_d1;
    vin_de_d2 <= vin_de_d1;
    vin_data_d2 <= vin_data_d1;   
end

endmodule 