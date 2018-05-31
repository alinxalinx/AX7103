/*-------------------------------------------------------------------------
Filename			:		ov5640_ddr_lcd.v
Description		:		read picture from sd, and store in ddr, display on lcd.
===========================================================================*/
`timescale 1ns / 1ps
module ov5640_ddr_lcd
(
   // Differential system clocks
     input                                        sys_clk_p,
     input                                        sys_clk_n,
     input                                        sys_rst,
     input                                        key1,
     input                                        key2,
     output                                       clk50m,
	
   /*ddr3接口信号*/	
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
	 output			                              lcd_hs,		   //horizontal sync 
	 output			                              lcd_vs,		   //vertical sync
	 output  [7:0]	                              lcd_r,		   //lcd R data
	 output	 [7:0]	                              lcd_g,		   //lcd G data
	 output	 [7:0]	                              lcd_b,		   //lcd B data
	
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
     output                                       cmos2_reset       //cmos reset


	
	//led status indication
//	 output   [3:0]                               led
	
);

wire [7:0] lcd_red;
wire [7:0] lcd_green;
wire [7:0] lcd_blue;

assign lcd_r = lcd_red;
assign lcd_g = lcd_green;
assign lcd_b = lcd_blue;

//---------------------------------------------
wire   phy_clk;
wire	clk_lcd;		   //lcd clock
wire	clk_camera;		   //cmos clock

system_ctrl	u_system_ctrl
(
	.clk				    (phy_clk),			  //ddr control clock
	.rst_n				    (sys_rst),		      //external reset

	.clk_c0				    (clk_lcd),		     //9MHz lcd clock
	.clk_c1				    (clk_camera),		 //24MHz sd clock
	.clk_c2                 (clk50m)

);
 

//CMOS OV5640上电延迟部分
wire initial_en;                       //OV5640 register configure enable
power_on_delay	power_on_delay_inst(
	.clk_50M                 (clk_camera),
	.reset_n                 (sys_rst),	
	.camera1_rstn            (cmos1_reset),
	.camera2_rstn            (cmos2_reset),	
	.camera_pwnd             (),
	.initial_en              (initial_en)		
);
 
//-------------------------------------
//CMOS1 Camera初始化部分
wire Cmos1_Config_Done;
reg_config	reg_config_inst1(
	.clk_25M                 (clk_camera),
	.camera_rstn             (cmos1_reset),
	.initial_en              (initial_en),		
	.i2c_sclk                (cmos1_scl),
	.i2c_sdat                (cmos1_sda),
	.reg_conf_done           (Cmos1_Config_Done),
	.reg_index               (),
	.clock_20k               ()

);

//-------------------------------------
//CMOS2 Camera初始化部分
wire Cmos2_Config_Done;
reg_config	reg_config_inst2(
	.clk_25M                 (clk_camera),
	.camera_rstn             (cmos2_reset),
	.initial_en              (initial_en),		
	.i2c_sclk                (cmos2_scl),
	.i2c_sdat                (cmos2_sda),
	.reg_conf_done           (Cmos2_Config_Done),
	.reg_index               (),
	.clock_20k               ()

);

//-------------------------------------
//CMOS 图像信号按键切换
wire cmos_pclk;
wire cmos_vsync;
wire cmos_href;
wire [7:0] cmos_d;

cmos_select	cmos_select_inst(
	.clk                    (clk_camera),
	.reset_n                (sys_rst),	
	.key1                   (key1),
	
	.cmos_pclk              (cmos_pclk),
    .cmos_vsync             (cmos_vsync),        
    .cmos_href              (cmos_href),
    .cmos_d                 (cmos_d),	
	
	.cmos1_pclk             (cmos1_pclk),
    .cmos1_vsync            (cmos1_vsync),        
    .cmos1_href             (cmos1_href),
    .cmos1_d                (cmos1_d),
    	
	.cmos2_pclk             (cmos2_pclk),
	.cmos2_vsync            (cmos2_vsync),		
	.cmos2_href             (cmos2_href),
	.cmos2_d                (cmos2_d)

);

//-------------------------------------
//Camera采样部分
wire        sys_we;
wire [255:0] sys_data_in;
wire	    init_calib_complete;			   //ddr init done

camera_capture	camera_capture_inst(
	.rst_n                   (sys_rst),	       //external reset  
	.init_done               (init_calib_complete & (Cmos1_Config_Done | Cmos2_Config_Done)),	   // init done
	.camera_pclk             (cmos_pclk),	   //cmos pxiel clock
	.camera_href             (cmos_href),	   //cmos hsync refrence
	.camera_vsync            (cmos_vsync),    //cmos vsync
	.camera_data             (cmos_d),        //cmos data
	.ddr_wren                (sys_we),         //ddr write enable
	.ddr_data_camera         (sys_data_in)    //ddr write data

);

//-------------------------------------
// lcd display
wire			 sys_rd; 					//rdfifo read enable
wire	[255:0]	 sys_data_out; 				//rdfifo read data 
  
lcd_disp	lcd_disp_inst
(
	//global clock
	.lcd_clk_i			   (clk_lcd),			    //lcd clock
	.lcd_rst			   (~sys_rst),		        //global reset
	.key2                  (key2),

	//lcd port
	.lcd_clk               (lcd_clk),
	.lcd_en                (lcd_en),
	.lcd_hsync			   (lcd_hs),		        //lcd horizontal sync 
	.lcd_vsync			   (lcd_vs),		        //lcd vertical sync
	.lcd_r			       (lcd_red),			        //lcd red data	
	.lcd_g			       (lcd_green),		            //lcd red data		
	.lcd_b			       (lcd_blue),			        //lcd red data	

	//user interface
	.ddr_rden   		   (sys_rd),			    //lcd read enable
	.ddr_data  		       (sys_data_out),	        //lcd data
	.ddr_init_done	       (init_calib_complete)	//ddr init done

);


//-------------------------------------
// ddr fifo control 
wire frame_write_done;
wire frame_read_done;
ddr_2fifo_top	ddr_2fifo_top_inst
(
	//global clock
    .sys_clk_p                      (sys_clk_p),
    .sys_clk_n                      (sys_clk_n),
    .phy_clk                        (phy_clk),                 //ddr control clock 
    .sys_rst                        (sys_rst),                 //global reset
    
	.clk_read				        (clk_lcd),		         //fifo read clock      
	.clk_write				        (cmos_pclk),	             //fifo write clock
	
	//ddr interface
    .ddr3_addr                      (ddr3_addr),   //ddr address    
    .ddr3_ba                        (ddr3_ba),     //ddr bank address
    .ddr3_cas_n                     (ddr3_cas_n),  //ddr column address strobe
    .ddr3_ck_n                      (ddr3_ck_n),   //ddr clock enable 
    .ddr3_ck_p                      (ddr3_ck_p),   //ddr positive clock    
    .ddr3_cke                       (ddr3_cke),    //ddr negative clock 
    .ddr3_ras_n                     (ddr3_ras_n),  //ddr row address strobe    
    .ddr3_we_n                      (ddr3_we_n),   //ddr write enable
    .ddr3_dq                        (ddr3_dq),     //ddr data    
    .ddr3_dqs_n                     (ddr3_dqs_n),  //ddr data positive clock    
    .ddr3_dqs_p                     (ddr3_dqs_p),  //ddr data negative clock    
    .ddr3_reset_n                   (ddr3_reset_n),//ddr reset
    .init_calib_complete            (init_calib_complete),//ddr init done
   
    .ddr3_cs_n                      (ddr3_cs_n),   //ddr chip select        
    .ddr3_dm                        (ddr3_dm),     //ddr data enable
    .ddr3_odt                       (ddr3_odt),     //ddr On-Die Termination
	
	//user interface
	.vin_vs                         (cmos_vsync),
    .vout_vs                        (lcd_vs), 
	.frame_write_done		        (frame_write_done),	   //ddr write one frame
	.frame_read_done  	            (frame_read_done),	   //ddr read one frame
	.sys_we	                        (sys_we),              //fifo write enable
	.sys_data_in	                (sys_data_in),         //fifo data input	
	.sys_rd	                        (sys_rd),	           //fifo read enable
	.sys_data_out	                (sys_data_out)	       //fifo data output


);


endmodule


