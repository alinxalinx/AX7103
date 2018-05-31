`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/09/07 13:39:28
// Design Name: 
// Module Name: TOP
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
    module TOP(
    
               // Differential system clocks
              input                                        sys_clk_p,
              input                                        sys_clk_n,
              input                                        sys_rst,
              input                                        key1,
              input                                        key2,
                     
            /*ddr3½Ó¿ÚÐÅºÅ*/    
              inout  [31:0]                                ddr3_dq,
              inout  [3:0]                                 ddr3_dqs_n,
              inout  [3:0]                                 ddr3_dqs_p,
              
              output  [14:0]                               ddr3_addr,
              output  [2:0]                                ddr3_ba,
              output                                       ddr3_ras_n,
              output                                       ddr3_cas_n,
              output                                       ddr3_we_n,
              output                                       ddr3_reset_n,
              output  [0:0]                                ddr3_ck_p,
              output  [0:0]                                ddr3_ck_n,
              output  [0:0]                                ddr3_cke,
              output  [0:0]                                ddr3_cs_n,
              output  [3:0]                                ddr3_dm,
              output  [0:0]                                ddr3_odt,
             
             //lcd port    
              output                                       lcd_clk,         //lcd clock
              output                                       lcd_en,          //lcd black enable
              output                                       lcd_hs,           //horizontal sync 
              output                                       lcd_vs,           //vertical sync
              output     [7:0]                             lcd_r,           //lcd R data
              output     [7:0]                             lcd_g,           //lcd G data
              output     [7:0]                             lcd_b,           //lcd B data
             
             //cmos1 interface
              output                                       cmos1_scl,         //cmos i2c clock
              inout                                        cmos1_sda,         //cmos i2c data
              input                                        cmos1_vsync,       //cmos vsync
              input                                        cmos1_href,        //cmos hsync refrence
              input                                        cmos1_pclk,        //cmos pxiel clock
            
              input   [7:0]                                cmos1_d,           //cmos data
              output                                       cmos1_reset,       //cmos reset
            
            
             //cmos2 interface
              output                                       cmos2_scl,         //cmos i2c clock
              inout                                        cmos2_sda,         //cmos i2c data
              input                                        cmos2_vsync,       //cmos vsync
              input                                        cmos2_href,        //cmos hsync refrence
              input                                        cmos2_pclk,        //cmos pxiel clock
            
              input   [7:0]                                cmos2_d,          //cmos data
              output                                       cmos2_reset     //cmos reset                          
        );
     
    wire clk50m;
        
     ov5640_ddr_lcd    u_ov5640_ddr_lcd
        (
            .sys_clk_p                    (sys_clk_p),            
            .sys_clk_n                    (sys_clk_n),            
        
            .sys_rst                      (sys_rst),             
            .key1                         (key1),
            .key2                         (key2),
            .clk50m                       (clk50m),
                    
            .ddr3_dq                      (ddr3_dq),       
            .ddr3_dqs_n                   (ddr3_dqs_n),    
            .ddr3_dqs_p                   (ddr3_dqs_p),
            .ddr3_addr                    (ddr3_addr),       
            .ddr3_ba                      (ddr3_ba),    
            .ddr3_ras_n                   (ddr3_ras_n),     
            .ddr3_cas_n                   (ddr3_cas_n),       
            .ddr3_we_n                    (ddr3_we_n),    
            .ddr3_reset_n                 (ddr3_reset_n),  
            .ddr3_ck_p                    (ddr3_ck_p),  
            .ddr3_ck_n                    (ddr3_ck_n),  
            .ddr3_cke                     (ddr3_cke), 
            .ddr3_cs_n                    (ddr3_cs_n),   
            .ddr3_dm                      (ddr3_dm), 
            .ddr3_odt                     (ddr3_odt), 
            
            .lcd_clk                      (lcd_clk),        
            .lcd_en                       (lcd_en),    
            .lcd_hs                       (lcd_hs),        
            .lcd_vs                       (lcd_vs),  
            .lcd_r                        (lcd_r),        
            .lcd_g                        (lcd_g),    
            .lcd_b                        (lcd_b),        
    
            .cmos1_scl                    (cmos1_scl),      
            .cmos1_sda                    (cmos1_sda),  
            .cmos1_vsync                  (cmos1_vsync),      
            .cmos1_href                   (cmos1_href),  
            .cmos1_pclk                   (cmos1_pclk),      
            .cmos1_d                      (cmos1_d),
            .cmos1_reset                  (cmos1_reset),  
            
            .cmos2_scl                    (cmos2_scl),      
            .cmos2_sda                    (cmos2_sda),  
            .cmos2_vsync                  (cmos2_vsync),      
            .cmos2_href                   (cmos2_href),  
            .cmos2_pclk                   (cmos2_pclk),      
            .cmos2_d                      (cmos2_d),
            .cmos2_reset                  (cmos2_reset)   
                                                                                  
        );    
endmodule
