/*-------------------------------------------------------------------------
Filename			:		bank_switch.v
Description		:		back switch for ddr read and write.
Modification History	:
Data			By			Version			Change Description
===========================================================================
15/02/1
--------------------------------------------------------------------------*/
module	bank_switch
(
	input				clk,
	input				rst_n,
	
	input  vin_vs,
	input  vout_vs,
	
	output	reg	[1:0]	wr_bank,
	output	reg	[1:0]	rd_bank
);


//----------------------------------
//negedge of bank_valid signal

reg vin_vs_d0;
reg vin_vs_d1;

reg vout_vs_d0;
reg vout_vs_d1;

always@(posedge clk)
begin
    vin_vs_d0 <= vin_vs;
    vin_vs_d1 <= vin_vs_d0;
end

always@(posedge clk)
begin
    vout_vs_d0 <= vout_vs;
    vout_vs_d1 <= vout_vs_d0;
end

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
        wr_bank <= 2'd0;
    else if(~vin_vs_d1 & vin_vs_d0) //vin rising
        wr_bank <= wr_bank + 2'd1;
end

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
        rd_bank <= 2'd0;
    else if(~vout_vs_d1 & vout_vs_d0) //vout rising
        rd_bank <= wr_bank - 2'd1;
end
endmodule
