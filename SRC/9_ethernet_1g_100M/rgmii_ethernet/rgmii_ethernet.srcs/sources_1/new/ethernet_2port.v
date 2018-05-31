`timescale 1ns / 1ps  
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    ethernet_test 
//////////////////////////////////////////////////////////////////////////////////
module ethernet_2port(
   input sys_clk_p,      // 开发板上差分输入时钟200Mhz， 正极
   input sys_clk_n,      // 开发板上差分输入时钟200Mhz， 负极  
   
   input key1,

	output e1_reset,
	output e1_mdc,
	inout  e1_mdio,

	output[3:0] rgmii1_txd,
	output rgmii1_txctl,
	output rgmii1_txc,
	input[3:0] rgmii1_rxd,
	input rgmii1_rxctl,
	input rgmii1_rxc,
	
	output e2_reset,
    output e2_mdc,
    inout  e2_mdio,

    output[3:0] rgmii2_txd,
    output rgmii2_txctl,
    output rgmii2_txc,
    input[3:0] rgmii2_rxd,
    input rgmii2_rxctl,
    input rgmii2_rxc	
  
    );
    
    
    
    
    //=========================================================================
    // 差分时钟转换成单端时钟
    //===========================================================================
    wire sys_clk_ibufg;
     IBUFGDS #
           (
            .DIFF_TERM    ("FALSE"),
            .IBUF_LOW_PWR ("FALSE")
            )
           u_ibufg_sys_clk
             (
              .I  (sys_clk_p),            //差分时钟的正端输入，需要和顶层模块的端口直接连接
              .IB (sys_clk_n),           // 差分时钟的负端输入，需要和顶层模块的端口直接连接
              .O  (sys_clk_ibufg)        //时钟缓冲输出
              );
              
    ethernet_test u1(
                  .sys_clk(sys_clk_ibufg),
                  .key1(key1),
                  
                  .e_reset(e1_reset),          
                  .e_mdc(e1_mdc),
                  .e_mdio(e1_mdio),               
  
                  .rgmii_txd(rgmii1_txd),
                  .rgmii_txctl(rgmii1_txctl),     
                  .rgmii_txc(rgmii1_txc),
                  .rgmii_rxd(rgmii1_rxd),     
                  .rgmii_rxctl(rgmii1_rxctl),
                  .rgmii_rxc(rgmii1_rxc) 
                  
          );
          
    ethernet_test u2(
                        .sys_clk(sys_clk_ibufg),
                        .key1(key1),
                        .e_reset(e2_reset),          
                        .e_mdc(e2_mdc),
                        .e_mdio(e2_mdio),               
        
                        .rgmii_txd(rgmii2_txd),
                        .rgmii_txctl(rgmii2_txctl),     
                        .rgmii_txc(rgmii2_txc),
                        .rgmii_rxd(rgmii2_rxd),     
                        .rgmii_rxctl(rgmii2_rxctl),
                        .rgmii_rxc(rgmii2_rxc) 
                        
                );  
                
                                
                
endmodule                      