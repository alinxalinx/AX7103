/*-------------------------------------------------------------------------
Filename			:		system_ctrl.v
===========================================================================
13/02/1
--------------------------------------------------------------------------*/
`timescale 1 ns / 1 ns
module system_ctrl
(
	input 		clk,	      //100MHz
	input 		rst_n,		  //global reset

	output 		clk_c0,	     //65Mhz	
	output 		clk_c1,       //25Mhz
	output 		clk_c2       //25Mhz	

);


//----------------------------------------------
//Component instantiation
wire 	locked;	
pll pll_inst
(
	.clk_in1	    (clk),
	.reset	        (~rst_n),
	.locked	        (locked),
			
	.clk_out1		(clk_c0),          //65Mhz	
	.clk_out2		(clk_c1),           //25Mhz	
	.clk_out3		(clk_c2)          
	

);


endmodule
