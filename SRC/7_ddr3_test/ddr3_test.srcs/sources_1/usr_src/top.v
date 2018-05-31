`timescale 1ps/1ps

module top

  (

   // Inouts
   inout [31:0]                       ddr3_dq,
   inout [3:0]                        ddr3_dqs_n,
   inout [3:0]                        ddr3_dqs_p,

   // Outputs
   output [14:0]                     ddr3_addr,
   output [2:0]                      ddr3_ba,
   output                            ddr3_ras_n,
   output                            ddr3_cas_n,
   output                            ddr3_we_n,
   output                            ddr3_reset_n,
   output [0:0]                      ddr3_ck_p,
   output [0:0]                      ddr3_ck_n,
   output [0:0]                      ddr3_cke,
   
   output [0:0]                      ddr3_cs_n,
   
   output [3:0]                      ddr3_dm,
   
   output [0:0]                      ddr3_odt,
   

   // Inputs
   
   // Differential system clocks
   input                             sys_clk_p,
   input                             sys_clk_n,
   

   //output                           init_calib_complete,
   
   output                           error,

   input                           sys_rst
   );

localparam nCK_PER_CLK           = 4;
localparam DQ_WIDTH              = 32;
localparam ADDR_WIDTH            = 29;
  localparam DATA_WIDTH            = 32;
  localparam PAYLOAD_WIDTH         = 32;

  localparam APP_DATA_WIDTH        = 2 * nCK_PER_CLK * PAYLOAD_WIDTH;
  localparam APP_MASK_WIDTH        = APP_DATA_WIDTH / 8;

      

  // Wire declarations
      
  wire [ADDR_WIDTH-1:0]                 app_addr;
  wire [2:0]                            app_cmd;
  wire                                  app_en;
  wire                                  app_rdy;
  wire [APP_DATA_WIDTH-1:0]             app_rd_data;
  wire                                  app_rd_data_end;
  wire                                  app_rd_data_valid;
  wire [APP_DATA_WIDTH-1:0]             app_wdf_data;
  wire                                  app_wdf_end;
  wire [APP_MASK_WIDTH-1:0]             app_wdf_mask;
  wire                                  app_wdf_rdy;
  wire                                  app_sr_active;
  wire                                  app_ref_ack;
  wire                                  app_zq_ack;
  wire                                  app_wdf_wren;

  wire                                  clk;
  wire                                  rst;





  ddr3 u_ddr3
      (
       
       
// Memory interface ports
       .ddr3_addr                      (ddr3_addr),
       .ddr3_ba                        (ddr3_ba),
       .ddr3_cas_n                     (ddr3_cas_n),
       .ddr3_ck_n                      (ddr3_ck_n),
       .ddr3_ck_p                      (ddr3_ck_p),
       .ddr3_cke                       (ddr3_cke),
       .ddr3_ras_n                     (ddr3_ras_n),
       .ddr3_we_n                      (ddr3_we_n),
       .ddr3_dq                        (ddr3_dq),
       .ddr3_dqs_n                     (ddr3_dqs_n),
       .ddr3_dqs_p                     (ddr3_dqs_p),
       .ddr3_reset_n                   (ddr3_reset_n),
       .init_calib_complete            (init_calib_complete),
      
       .ddr3_cs_n                      (ddr3_cs_n),
       .ddr3_dm                        (ddr3_dm),
       .ddr3_odt                       (ddr3_odt),
// Application interface ports
       .app_addr                       (app_addr),
       .app_cmd                        (app_cmd),
       .app_en                         (app_en),
       .app_wdf_data                   (app_wdf_data),
       .app_wdf_end                    (app_wdf_end),
       .app_wdf_wren                   (app_wdf_wren),
       .app_rd_data                    (app_rd_data),
       .app_rd_data_end                (app_rd_data_end),
       .app_rd_data_valid              (app_rd_data_valid),
       .app_rdy                        (app_rdy),
       .app_wdf_rdy                    (app_wdf_rdy),
       .app_sr_req                     (1'b0),
       .app_ref_req                    (1'b0),
       .app_zq_req                     (1'b0),
       .app_sr_active                  (app_sr_active),
       .app_ref_ack                    (app_ref_ack),
       .app_zq_ack                     (app_zq_ack),
       .ui_clk                         (clk),
       .ui_clk_sync_rst                (rst),
      
       .app_wdf_mask                   (app_wdf_mask),
      
       
// System Clock Ports
       .sys_clk_p                       (sys_clk_p),
       .sys_clk_n                       (sys_clk_n),
      
       .sys_rst                        (sys_rst)
       );
// End of User Design top instance


wire wr_burst_data_req;
wire wr_burst_finish;
wire rd_burst_finish;
wire rd_burst_req;
wire wr_burst_req;
wire[9:0] rd_burst_len;
wire[9:0] wr_burst_len;
wire[28:0] rd_burst_addr;
wire[28:0] wr_burst_addr;
wire rd_burst_data_valid;
wire[48* 8 - 1 : 0] rd_burst_data;
wire[48* 8 - 1 : 0] wr_burst_data;
mem_burst
#(
	.MEM_DATA_BITS(APP_DATA_WIDTH),
	.ADDR_BITS(ADDR_WIDTH)
)
 mem_burst_m0
(
	.rst(rst),                                  /*复位*/
	.mem_clk(clk),                              /*接口时钟*/
	.rd_burst_req(rd_burst_req),                /*读请求*/
	.wr_burst_req(wr_burst_req),                /*写请求*/
	.rd_burst_len(rd_burst_len),                /*读数据长度*/
	.wr_burst_len(wr_burst_len),                 /*写数据长度*/
	.rd_burst_addr(rd_burst_addr),               /*读首地址*/
	.wr_burst_addr(wr_burst_addr),               /*写首地址*/
	.rd_burst_data_valid(rd_burst_data_valid),   /*读出数据有效*/
	.wr_burst_data_req(wr_burst_data_req),       /*写数据信号*/
	.rd_burst_data(rd_burst_data),               /*读出的数据*/
	.wr_burst_data(wr_burst_data),               /*写入的数据*/
	.rd_burst_finish(rd_burst_finish),           /*读完成*/
	.wr_burst_finish(wr_burst_finish),           /*写完成*/
	.burst_finish(),                             /*读或写完成*/
	
	///////////////////
   .app_addr(app_addr),
   .app_cmd(app_cmd),
   .app_en(app_en),
   .app_wdf_data(app_wdf_data),
   .app_wdf_end(app_wdf_end),
   .app_wdf_mask(app_wdf_mask),
   .app_wdf_wren(app_wdf_wren),
   .app_rd_data(app_rd_data),
   .app_rd_data_end(app_rd_data_end),
   .app_rd_data_valid(app_rd_data_valid),
   .app_rdy(app_rdy),
   .app_wdf_rdy(app_wdf_rdy),
   .ui_clk_sync_rst(),  
   .init_calib_complete(init_calib_complete)
);
mem_test
#(
	.MEM_DATA_BITS(APP_DATA_WIDTH),
	.ADDR_BITS(ADDR_WIDTH)
)
mem_test_m0
(
	.rst(rst),                                 /*澶嶄綅*/
	.mem_clk(clk),                               /*鎺ュ彛鏃堕挓*/
	.rd_burst_req(rd_burst_req),                          /*璇昏锟??*/
	.wr_burst_req(wr_burst_req),                          /*鍐欒锟??*/
	.rd_burst_len(rd_burst_len),                     /*璇绘暟鎹暱锟??*/
	.wr_burst_len(wr_burst_len),                     /*鍐欐暟鎹暱锟??*/
	.rd_burst_addr(rd_burst_addr),        /*璇婚鍦板潃*/
	.wr_burst_addr(wr_burst_addr),        /*鍐欓鍦板潃*/
	.rd_burst_data_valid(rd_burst_data_valid),                  /*璇诲嚭鏁版嵁鏈夋晥*/
	.wr_burst_data_req(wr_burst_data_req),                    /*鍐欐暟鎹俊锟??*/
	.rd_burst_data(rd_burst_data),   /*璇诲嚭鐨勬暟锟??*/
	.wr_burst_data(wr_burst_data),    /*鍐欏叆鐨勬暟锟??*/
	.rd_burst_finish(rd_burst_finish),                      /*璇诲畬锟??*/
	.wr_burst_finish(wr_burst_finish),                      /*鍐欏畬锟??*/

	.error(error)
);

wire probe0;
wire probe1;
wire probe2;
wire probe3;
wire probe4;
wire probe5;
wire probe6;
wire probe7;
wire [255 : 0] probe8;
wire [255 : 0] probe9;
wire [28 : 0] probe10;


ila_0 u_ila_0(
	.clk(clk),
	.probe0(probe0),
	.probe1(probe1),
	.probe2(probe2),
	.probe3(probe3),
	.probe4(probe4),
	.probe5(probe5),
	.probe6(probe6),
	.probe7(probe7),
	.probe8(probe8),
	.probe9(probe9),
    .probe10(probe10)						
);
assign probe0 = rd_burst_req;
assign probe1 = wr_burst_req;
assign probe2 = rd_burst_data_valid;
assign probe3 = wr_burst_data_req;
assign probe4 = rd_burst_finish;
assign probe5 = wr_burst_finish;
assign probe6 = error;
assign probe7 = init_calib_complete;
assign probe8 = wr_burst_data[255:0];
assign probe9 = rd_burst_data[255:0];
assign probe10 = app_addr[28:0];


endmodule
