`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//双通道的12bit AD输入测试程序
//////////////////////////////////////////////////////////////////////////////////
module ad9226_test(
                input          sys_clk_p,
                input          sys_clk_n,  
				input          reset_n,

	            input          rx,                   //uart rx
                output         tx,                  //uart tx 
				
				input [11:0]   ad1_in,
				output         ad1_clk,

				input [11:0]   ad2_in,
				output         ad2_clk	

    );
    
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

  ////////////////产生AD1，AD2的时钟////////////////////////    
  wire ad_clk;
  wire clk50m;     
 PLL PLL_inst
            (// Clock in ports
             .clk_in1(sys_clk_ibufg),      // IN
             // Clock out ports
             .clk_out1(ad_clk),     // OUT 65Mhz
             .clk_out2(clk50m),     // OUT 50Mhz
             // Status and control signals
             .reset(1'b0),// IN
             .locked());      // OUT        
    

assign ad1_clk=ad_clk;
assign ad2_clk=ad_clk;

wire [11:0] ad_ch1;
wire [11:0] ad_ch2;
wire [7:0]  ch1_sig;
wire [7:0]  ch2_sig;
wire [19:0] ch1_dec;
wire [19:0] ch2_dec;


/****************AD采样程序**************/
ad u1 (
		.ad_clk                  (ad_clk),                           
		.ad1_in                  (ad1_in),             //ad1 input
		.ad2_in                  (ad2_in),	           //ad2 input	
        .ad_ch1                  (ad_ch1),             //ad1 data 12bit
        .ad_ch2                  (ad_ch2)              //ad2 data
 );

/**********AD十六进制转十进制***********/
volt_cal u2(
		.ad_clk           		 (ad_clk),	
		.ad_ch1            		 (ad_ch1),           //ad1 data 12bit
		.ad_ch2                  (ad_ch2),           //ad2 data 12bit
	
		.ch1_dec                 (ch1_dec),         //ad1 BCD voltage
		.ch2_dec                 (ch2_dec),         //ad2 BCD voltage
	
		.ch1_sig                 (ch1_sig),         //ch1 ad 正负
		.ch2_sig                 (ch2_sig)          //ch2 ad 正负
	
    );

/**********AD数据Uart串口发送程序***********/
uart u3(
		.clk50           		 (clk50m),	
		.reset_n           		 (reset_n),	

		.ch1_dec                 (ch1_dec),         //ad1 BCD voltage
		.ch2_dec                 (ch2_dec),         //ad2 BCD voltage
	
		.ch1_sig                 (ch1_sig),         //ch1 ad 正负
		.ch2_sig                 (ch2_sig),          //ch2 ad 正负
		
		.tx                      (tx)
		
	
    );

wire [11 : 0] probe0;
wire [11 : 0] probe1;

ila_0 u_ila_0(
	.clk(ad_clk),
	.probe0(probe0),
	.probe1(probe1)
						
);
assign probe0 = ad_ch1;
assign probe1 = ad_ch2;   


endmodule
