`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//J13 PIN40 EXTERNAL IO 40
//////////////////////////////////////////////////////////////////////////////////
module adda_test(
    input          sys_clk_p,
    input          sys_clk_n,  
    	 
	 output daclk,
     output [7:0] dadata,       //DA data
	 
	 output adclk,
	 input [7:0] addata        //AD data

    );


reg [8:0] rom_addr;
reg [7:0] ad_data;

wire [7:0] rom_data;
wire clk_da;
wire clk_ad;

assign dadata=rom_data;
assign daclk=clk_da;
assign adclk=clk_ad;

////////////////差分时钟转换成单端时钟////////////////////////
    wire sys_clk_ibufg;
     IBUFGDS #
           (
            .DIFF_TERM    ("FALSE"),
            .IBUF_LOW_PWR ("FALSE")
            )
           u_ibufg_sys_clk
             (
              .I  (sys_clk_p),
              .IB (sys_clk_n),
              .O  (sys_clk_ibufg)
              );

//DA output sin waveform
always @(negedge clk_da)
begin
     rom_addr <= rom_addr + 1'b1 ; 
end 

always @(posedge clk_ad)
begin
      ad_data <= addata ;  
end 


ROM ROM_inst (
  .clka(clk_da), // input clka
  .addra(rom_addr), // input [8 : 0] addra
  .douta(rom_data) // output [7 : 0] douta
);


PLL PLL_inst
   (// Clock in ports
    .clk_in1(sys_clk_ibufg),      // IN
    // Clock out ports
    .clk_out1(clk_ad),     // OUT 32Mhz
    .clk_out2(clk_da),     // OUT 32Mhz
    // Status and control signals
    .reset(1'b0),// IN
    .locked());      // OUT
    
wire [7 : 0] probe0;
wire [7 : 0] probe1;

ila_0 u_ila_0(
	.clk(clk_ad),
	.probe0(probe0),
	.probe1(probe1)
						
);
assign probe0 = dadata;
assign probe1 = addata;   

endmodule
