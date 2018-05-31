/*-------------------------------------------------------------------------
Filename			:		ddr_2fifo_top.v
Description		:		ddr read and write with fifo controller.
==========================================================================*/
`timescale 1ns/1ns
module	ddr_2fifo_top
#(
	parameter DATA_WIDTH = 256,        //数据宽度
	parameter ADDR_WIDTH = 29         //地址宽度
)
(
   // Differential system clocks
     input                                        sys_clk_p,
     input                                        sys_clk_n,
     output                                       phy_clk,
     input                                        sys_rst,
     output                                       init_calib_complete,    //ddr initial done	
         
	 input			                              clk_read,			  //fifo data read clock	
	 input			                              clk_write,		  //fifo data write clock

   /*ddr3接口信号*/	
    inout  [31:0]                                  ddr3_dq,
    inout  [3:0]                                   ddr3_dqs_n,
    inout  [3:0]                                   ddr3_dqs_p,
    
    output  [14:0]                                 ddr3_addr,
    output  [2:0]                                  ddr3_ba,
    output                                         ddr3_ras_n,
    output                                         ddr3_cas_n,
    output                                         ddr3_we_n,
    output                                         ddr3_reset_n,
    output  [0:0]                                  ddr3_ck_p,
    output  [0:0]                                  ddr3_ck_n,
    output  [0:0]                                  ddr3_cke,
    output  [0:0]                                  ddr3_cs_n,
    output  [3:0]                                  ddr3_dm,
    output  [0:0]                                  ddr3_odt,
	
	//user interface
	output			                               frame_write_done,	//ddr write one frame
	output			                               frame_read_done,  	//ddr read one frame
	input				                           sys_we,				//fifo write enable
	input	[ DATA_WIDTH - 1: 0]                   sys_data_in,		    //fifo data input
	input				                           sys_rd,				//fifo read enable
	output  [ DATA_WIDTH - 1: 0]                   sys_data_out,		//fifo data output
	
	input                                          vin_vs,	           //cmos帧同步	
	input                                          vout_vs		       //vga帧同步	


);

//-----------------------------------------------
wire			              wr_burst_req;				//ddr write request
wire	[ ADDR_WIDTH - 1:0]	  wr_burst_addr;				//ddr write address 
wire                          wr_burst_data_req;      //ddr write data request
wire   [ DATA_WIDTH - 1:0]    wr_burst_data;	    	   //fifo 2 ddr data input	
wire                          wr_burst_finish;        //ddr write burst finish	

wire                          rd_burst_req;	         //ddr read request
wire   [ ADDR_WIDTH - 1:0]    rd_burst_addr;          //ddr read address
wire                          rd_burst_data_valid;    //ddr read data valid
wire   [ DATA_WIDTH - 1:0]    rd_burst_data;  	      //ddr 2 fifo data input
wire                          rd_burst_finish;        //ddr read burst finish	

wire  [9:0]                   wr_burst_len;            //ddr write burst length
wire  [9:0]                   rd_burst_len;  		      //ddr read burst length

wire                          rst;


//------------------------------------------------
//ddr control module instantiation
ddr_ctrl		ddr_ctrl_inst
(
	//global clock
    .sys_clk_p                      (sys_clk_p),
    .sys_clk_n                      (sys_clk_n),
	.clk  			                (phy_clk),		         //ddr control clock	
	.rst                            (rst),

	.sys_rst			            (sys_rst),			     //global reset

	//ddr read&write internal interface		
	.wr_burst_req		            (wr_burst_req), 	        //ddr write request
	.wr_burst_addr		            (wr_burst_addr),      	//ddr write address 	
	.wr_burst_data_req              (wr_burst_data_req), 	//ddr write data request
	.wr_burst_data		            (wr_burst_data),     	//fifo 2 ddr data input	
	.wr_burst_finish	            (wr_burst_finish),       //ddr write burst finish	
	
	.rd_burst_req		            (rd_burst_req), 	       //ddr read request
	.rd_burst_addr		            (rd_burst_addr), 	   //ddr read address
	.rd_burst_data_valid            (rd_burst_data_valid),  //ddr read data valid
	.rd_burst_data		            (rd_burst_data),   	   //ddr 2 fifo data input
	.rd_burst_finish	            (rd_burst_finish),      //ddr read burst finish	

	//burst length
	.wr_burst_len		            (10'd102),	           //ddr write burst length
	.rd_burst_len		            (10'd102),		        //ddr read burst length
	
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
    .ddr3_odt                       (ddr3_odt)     //ddr On-Die Termination

);

					
//------------------------------------------------
//dcfifo_ctrl module instantiation
wire [1:0] wr_bank;                             //ddr write bank address
wire [1:0] rd_bank;                             //ddr read bank address

dcfifo_ctrl u_dcfifo_ctrl
(
	//global clock
	.clk_ref			           (phy_clk),			     //sdram	reference clock
	.rst_n				           (~rst),			         //global reset
	.clk_read			           (clk_read),     	         //fifo data read clock	
	.clk_write			           (clk_write),     	     //fifo data write clock
	
	.vin_vs                        (vin_vs),    	         //cmos帧同步	
    .vout_vs                       (vout_vs),		    	 //VGAs帧同步	
	
	//brust length	
	.wr_length			           (10'd102),		         //ddr write burst length
	.rd_length			           (10'd102),		         //ddr read burst length
	.wr_addr			           ({wr_bank,20'd0}),		 //ddr start write address
	.wr_max_addr		           ({wr_bank,20'd8160}),	 //ddr max write address 480*272 *16bit/256bit
	.rd_addr			           ({rd_bank,20'd0}),		 //ddr start read address
	.rd_max_addr		           ({rd_bank,20'd8160}),	 //sdram max read address 480*272  *16bit/256bit

	//wrfifo:  fifo 2 sdram
	.wrf_wrreq			           (sys_we),			     //fifo write enable		
	.wrf_din			           (sys_data_in),		     //fifo data input
	.ddr_wr_req		               (wr_burst_req),	         //ddr write request
	.ddr_wr_ack                    (wr_burst_data_req),      //ddr write data request
	.ddr_din		               (wr_burst_data),		     //fifo 2 ddr data input	
	.ddr_wraddr		               (wr_burst_addr),		     //ddr write address
	.ddr_wr_finish	               (wr_burst_finish),        //ddr write burst finish	
	
	//rdfifo: sdram 2 fifo
	.rdf_rdreq			           (sys_rd),			     //fifo read enable	
	.rdf_dout			           (sys_data_out),		     //fifo data output
	.ddr_rd_req		               (rd_burst_req),		     //ddr read request
	.ddr_rd_ack	                   (rd_burst_data_valid),    //ddr read data valid
	.ddr_dout			           (rd_burst_data),		     //ddr 2 fifo data input	
	.ddr_rdaddr		               (rd_burst_addr),		     //sdram read address
	.ddr_rd_finish		           (rd_burst_finish),        //ddr read burst finish	
	
	//sdram address control	
	.ddr_init_done	               (init_calib_complete),    //ddr init done	
	.frame_write_done	           (frame_write_done),	     //sdram write one frame
	.frame_read_done	           (frame_read_done)	     //sdram read one frame

);

//------------------------------------------------
//dcfifo_ctrl module instantiation
bank_switch	bank_switch_inst
(
	.clk						   (phy_clk),			      //ddr	write clock
	.rst_n					       (~rst),		              //global reset
	.vin_vs                        (vin_vs),    	          //cmos帧同步	
    .vout_vs                       (vout_vs),                 //VGAs帧同步    
 	
	.wr_bank					   (wr_bank),                 //ddr write bank address
	.rd_bank					   (rd_bank)                  //ddr read bank address
);


endmodule
