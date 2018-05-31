module ddr_ctrl
#(
	parameter DATA_WIDTH = 256,        //数据宽度
	parameter ADDR_WIDTH = 29         //地址宽度
)
(
   // Differential system clocks
    input                    sys_clk_p,
    input                    sys_clk_n,
    input                    sys_rst,
	
	output                   clk,
	output                   rst,

/*ddr读写用户接口信号*/	
    output                   init_calib_complete,     //ddr initial done

	input                    wr_burst_req,            //DDR Burst写请求         	
	input  [9:0]             wr_burst_len,	          //DDR Burst写长度
	input [ADDR_WIDTH - 1:0] wr_burst_addr,           //DDR Burst写地址
    output                   wr_burst_data_req,	      //写入数据请求	
	input [DATA_WIDTH - 1:0] wr_burst_data,           //DDR Burst写数据
    output                   wr_burst_finish,         //DDR Burst写完成信号
	
	input                    rd_burst_req,            //DDR Burst读请求 
	input  [9:0]             rd_burst_len,	          //DDR Burst读长度
	input [ADDR_WIDTH - 1:0] rd_burst_addr,           //DDR Burst读地址		
    output                   rd_burst_data_valid,     //DDR Burst读数据有效		
	output[DATA_WIDTH - 1:0] rd_burst_data,           //DDR Burst读数据
    output                   rd_burst_finish,         //DDR Burst读完成信号
	
/*ddr3接口信号*/	
    inout [31:0]             ddr3_dq,
    inout [3:0]              ddr3_dqs_n,
    inout [3:0]              ddr3_dqs_p,

    output [14:0]            ddr3_addr,
    output [2:0]             ddr3_ba,
    output                   ddr3_ras_n,
    output                   ddr3_cas_n,
    output                   ddr3_we_n,
    output                   ddr3_reset_n,
    output [0:0]             ddr3_ck_p,
    output [0:0]             ddr3_ck_n,
    output [0:0]             ddr3_cke,
    output [0:0]             ddr3_cs_n,
    output [3:0]             ddr3_dm,
    output [0:0]             ddr3_odt
);


  // Wire declarations
      
  wire [ADDR_WIDTH-1:0]                 app_addr;
  wire [2:0]                            app_cmd;
  wire                                  app_en;
  wire                                  app_rdy;
  wire [DATA_WIDTH-1:0]                 app_rd_data;
  wire                                  app_rd_data_end;
  wire                                  app_rd_data_valid;
  wire [DATA_WIDTH-1:0]                 app_wdf_data;
  wire                                  app_wdf_end;
  wire [DATA_WIDTH-1:0]                 app_wdf_mask;
  wire                                  app_wdf_rdy;
  wire                                  app_sr_active;
  wire                                  app_ref_ack;
  wire                                  app_zq_ack;
  wire                                  app_wdf_wren;


//实例化mem_burst
mem_burst
#(
	.MEM_DATA_BITS(DATA_WIDTH),
	.ADDR_BITS(ADDR_WIDTH)
)
 mem_burst_m0
(
   .rst(rst),                                  /*复位*/
   .mem_clk(clk),                              /*接口时钟*/
   .rd_burst_req(rd_burst_req),                /*DDR Burst读请求*/
   .wr_burst_req(wr_burst_req),                /*DDR Burst写请求*/
   .rd_burst_len(rd_burst_len),                /*DDR Burst读数据长度*/
   .wr_burst_len(wr_burst_len),                 /*DDR Burst写数据长度*/
   .rd_burst_addr(rd_burst_addr),               /*DDR Burst读首地址*/
   .wr_burst_addr(wr_burst_addr),               /*DDR Burst写首地址*/
   .rd_burst_data_valid(rd_burst_data_valid),   /*DDR Burst读出数据有效*/
   .wr_burst_data_req(wr_burst_data_req),       /*DDR Burst写数据信号*/
   .rd_burst_data(rd_burst_data),               /*DDR Burst读出的数据*/
   .wr_burst_data(wr_burst_data),               /*DDR Burst写入的数据*/
   .rd_burst_finish(rd_burst_finish),           /*DDR Burst读完成*/
   .wr_burst_finish(wr_burst_finish),           /*DDR Burst写完成*/
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

//实例化ddr3.v IP
  ddr3 ddr_m0
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
      
       .sys_rst                         (sys_rst)
       );
	
endmodule 

