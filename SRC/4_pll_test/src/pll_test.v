`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    pll_test 
//////////////////////////////////////////////////////////////////////////////////
module pll_test(
                input sys_clk_p,
                input sys_clk_n,
                input rst_n,
				output clk_out           //pll clock output J5_Pin3

    );
    
/////////////////////差分输入转单端////////////////////////////
wire sys_clk_ibufg;
 IBUFGDS #
       (
        .DIFF_TERM    ("TRUE"),
        .IBUF_LOW_PWR ("FALSE")
        )
       u_ibufg_sys_clk
         (
          .I  (sys_clk_p),
          .IB (sys_clk_n),
          .O  (sys_clk_ibufg)
          );


wire locked;
wire pll_clk_o;



/////////////////////PLL IP 调用////////////////////////////
clk_wiz_0 clk_wiz_0_inst
   (// Clock in ports
    .clk_in1(sys_clk_ibufg),            // IN 200Mhz
    // Clock out ports
    .clk_out1(),              // OUT 200Mhz
    .clk_out2(),              // OUT 100Mhz
    .clk_out3(),              // OUT 50Mhz
    .clk_out4(pll_clk_o),     // OUT 25Mhz	 
    // Status and control signals	 
    .reset(~rst_n),// IN
    .locked(locked));      // OUT


///////////////调用ODDR2使时钟信号通过普通IO输出//////////////////	  
ODDR2 #(
      .DDR_ALIGNMENT("NONE"),     // Sets output alignment to "NONE", "C0" or "C1"
      .INIT(1'b0),                // Sets initial state of the Q output to 1'b0 or 1'b1
      .SRTYPE("SYNC")             // Specifies "SYNC" or "ASYNC" set/reset
       ) ODDR2_inst (
      .Q(clk_out),                // 1-bit DDR output data
      .C0(pll_clk_o),             // 1-bit clock input
      .C1(~pll_clk_o),            // 1-bit clock input
      .CE(1'b1),                  // 1-bit clock enable input
      .D0(1'b1),                  // 1-bit data input (associated with C0)
      .D1(1'b0),                  // 1-bit data input (associated with C1)
      .R(1'b0),                   // 1-bit reset input
      .S(1'b0)                    // 1-bit set input
    );	  
	  

endmodule
