`timescale 1ps/1ps

module top
(
	inout                              hdmi_scl,
	inout                              hdmi_sda,
	output                             hdmi_nreset,
	output                             hdmi_in_nreset,
	input                              vin_clk,
	input                              vin_hs,
	input                              vin_vs,
	input                              vin_de,
	input[23:0]                        vin_data,
	
	output                             vout_clk,
	output                             vout_hs,
	output                             vout_vs,
	output                             vout_de,
	output[23:0]                       vout_data
	,
	inout [31:0]                       ddr3_dq,
	inout [3:0]                        ddr3_dqs_n,
	inout [3:0]                        ddr3_dqs_p,
	output [14:0]                      ddr3_addr,
	output [2:0]                       ddr3_ba,
	output                             ddr3_ras_n,
	output                             ddr3_cas_n,
	output                             ddr3_we_n,
	output                             ddr3_reset_n,
	output [0:0]                       ddr3_ck_p,
	output [0:0]                       ddr3_ck_n,
	output [0:0]                       ddr3_cke,
	output [0:0]                       ddr3_cs_n,
	output [3:0]                       ddr3_dm,
	output [0:0]                       ddr3_odt,
	//Differential system clocks
	input                              sys_clk_p,
	input                              sys_clk_n,
	output[3:0]                        led,
	input                              sys_rst
   );

localparam nCK_PER_CLK                 = 4;
localparam ADDR_WIDTH                  = 23;
localparam PAYLOAD_WIDTH               = 32;
localparam APP_DATA_WIDTH              = 64;
localparam APP_MASK_WIDTH              = APP_DATA_WIDTH / 8;


wire M_AXI_ACLK;
// Master Write Address
wire [0:0]  s00_axi_awid;
wire [31:0] s00_axi_awaddr;
wire [7:0]  s00_axi_awlen;    // burst length: 0-255
wire [2:0]  s00_axi_awsize;   // burst size: fixed 2'b011
wire [1:0]  s00_axi_awburst;  // burst type: fixed 2'b01(incremental burst)
wire        s00_axi_awlock;   // lock: fixed 2'b00
wire [3:0]  s00_axi_awcache;  // cache: fiex 2'b0011
wire [2:0]  s00_axi_awprot;   // protect: fixed 2'b000
wire [3:0]  s00_axi_awqos;    // qos: fixed 2'b0000
wire [0:0]  s00_axi_awuser;   // user: fixed 32'd0
wire        s00_axi_awvalid;
wire        s00_axi_awready;

// master write data
wire [63:0] s00_axi_wdata;
wire [7:0]  s00_axi_wstrb;
wire        s00_axi_wlast;
wire [0:0]  s00_axi_wuser;
wire        s00_axi_wvalid;
wire        s00_axi_wready;

// master write response
wire [0:0]   s00_axi_bid;
wire [1:0]   s00_axi_bresp;
wire [0:0]   s00_axi_buser;
wire         s00_axi_bvalid;
wire         s00_axi_bready;

// master read address
wire [0:0]  s00_axi_arid;
wire [31:0] s00_axi_araddr;
wire [7:0]  s00_axi_arlen;
wire [2:0]  s00_axi_arsize;
wire [1:0]  s00_axi_arburst;
wire [1:0]  s00_axi_arlock;
wire [3:0]  s00_axi_arcache;
wire [2:0]  s00_axi_arprot;
wire [3:0]  s00_axi_arqos;
wire [0:0]  s00_axi_aruser;
wire        s00_axi_arvalid;
wire        s00_axi_arready;

// master read data
wire [0:0]   s00_axi_rid;
wire [63:0]  s00_axi_rdata;
wire [1:0]   s00_axi_rresp;
wire         s00_axi_rlast;
wire [0:0]   s00_axi_ruser;
wire         s00_axi_rvalid;
wire         s00_axi_rready;


wire [3 : 0] m_axi_awid                   ;
wire [31 : 0] m_axi_awaddr                ;
wire [7 : 0] m_axi_awlen                  ;
wire [2 : 0] m_axi_awsize                 ;
wire [1 : 0] m_axi_awburst                ;
wire m_axi_awlock                         ;
wire [3 : 0] m_axi_awcache                ;
wire [2 : 0] m_axi_awprot                 ;
wire [3 : 0] m_axi_awqos                  ;
wire m_axi_awvalid                        ;
wire m_axi_awready                        ;
wire [255 : 0] m_axi_wdata                ;
wire [31 : 0] m_axi_wstrb                 ;
wire m_axi_wlast                          ;
wire m_axi_wvalid                         ;
wire m_axi_wready                         ;
wire [3 : 0] m_axi_bid                    ;
wire [1 : 0] m_axi_bresp                  ;
wire m_axi_bvalid                         ;
wire m_axi_bready                         ;
wire [3 : 0] m_axi_arid                   ;
wire [31 : 0] m_axi_araddr                ;
wire [7 : 0] m_axi_arlen                  ;
wire [2 : 0] m_axi_arsize                 ;
wire [1 : 0] m_axi_arburst                ;
wire m_axi_arlock                         ;
wire [3 : 0] m_axi_arcache                ;
wire [2 : 0] m_axi_arprot                 ;
wire [3 : 0] m_axi_arqos                  ;
wire m_axi_arvalid                        ;
wire m_axi_arready                        ;
wire [3 : 0] m_axi_rid                    ;
wire [255 : 0] m_axi_rdata                ;
wire [1 : 0] m_axi_rresp                  ;
wire m_axi_rlast                          ;
wire m_axi_rvalid                         ;
wire m_axi_rready                         ;






wire                                   ui_clk;
wire                                   ui_clk_sync_rst;
wire                                   init_calib_complete;
wire                                   sys_clk;
wire                                   done;
wire                                   error;
wire                                   heartbeat;

wire                                   wr_burst_data_req;
wire                                   wr_burst_finish;
wire                                   rd_burst_finish;
wire                                   rd_burst_req;
wire                                   wr_burst_req;
wire[9:0]                              rd_burst_len;
wire[9:0]                              wr_burst_len;
wire[ADDR_WIDTH - 1:0]                 rd_burst_addr;
wire[ADDR_WIDTH - 1:0]                 wr_burst_addr;
wire                                   rd_burst_data_valid;
wire[APP_DATA_WIDTH - 1 : 0]           rd_burst_data;
wire[APP_DATA_WIDTH - 1 : 0]           wr_burst_data;

wire                                   read_req;
wire                                   read_req_ack;
wire                                   read_en;
wire[31:0]                             read_data;
wire                                   write_en;
wire[31:0]                             write_data;
wire                                   write_req;
wire                                   write_req_ack;
wire                                   ext_mem_clk;       //external memory clock
wire                                   video_clk;         //video pixel clock
wire                                   hs;
wire                                   vs;
wire                                   de;
reg                                    vin_de_d0;
reg[23:0]                              vin_data_d0;

wire[1:0]                              write_addr_index;
wire[1:0]                              read_addr_index;
wire[9:0]                              lut_index;
wire[31:0]                             lut_data;
wire                                   clk_100m;
wire                                   rst_n;
wire                                   locked;
assign vout_hs = hs;
assign vout_vs = vs;
assign vout_de = de;
assign vout_clk = video_clk;
assign ext_mem_clk = s00_axi_aclk;
assign s00_axi_aclk = video_clk;
assign fan_pwm = 1'b0;
assign led[3] = heartbeat;
assign led[2] = init_calib_complete;
assign led[1] = error;
assign led[0] = done;
assign write_en = vin_de_d0;
assign write_data = vin_data_d0;
assign rst_n = locked;
assign hdmi_nreset = rst_n;
assign hdmi_in_nreset = rst_n;

always@(posedge vin_clk)
begin
	vin_de_d0 <= vin_de;
	vin_data_d0 <= vin_data;
end

IBUFDS sys_clk_ibufgds
(
	.O  (sys_clk),
	.I  (sys_clk_p),
	.IB (sys_clk_n)
);
sys_pll sys_pll_m0
 (
	.clk_in1                (sys_clk    ),
	.clk_out1               (video_clk  ),
	.clk_out2               (clk_100m   ),
	.reset                  (1'b0       ),
	.locked                 (locked     )
 );
 
reg[31:0] timer;
reg  flag;
always@(posedge ui_clk)
begin
	if(timer >= 32'd99_999_999)
	begin
		flag <= ~flag;
		timer <= 32'd0;
	end
	else
	begin
		timer <= timer + 32'd1;
	end
end

//I2C master controller
i2c_config i2c_config_m0(
	.rst                        (~rst_n                   ),
	.clk                        (clk_100m                 ),
	.clk_div_cnt                (16'd500                  ),
	.i2c_addr_2byte             (1'b0                     ),
	.lut_index                  (lut_index                ),
	.lut_dev_addr               (lut_data[31:24]          ),
	.lut_reg_addr               (lut_data[23:8]           ),
	.lut_reg_data               (lut_data[7:0]            ),
	.error                      (                         ),
	.done                       (                         ),
	.i2c_scl                    (hdmi_scl                 ),
	.i2c_sda                    (hdmi_sda                 )
);
//configure look-up table
lut_hdmi lut_hdmi_m0(
	.lut_index                  (lut_index                ),
	.lut_data                   (lut_data                 )
);

ddr3 u_ddr3 (
	// Memory interface ports
	.ddr3_addr                      (ddr3_addr), 
	.ddr3_ba                        (ddr3_ba), 
	.ddr3_cas_n                     (ddr3_cas_n), 
	.ddr3_ck_n                      (ddr3_ck_n), 
	.ddr3_ck_p                      (ddr3_ck_p),
	.ddr3_cke                       (ddr3_cke),  
	.ddr3_ras_n                     (ddr3_ras_n), 
	.ddr3_reset_n                   (ddr3_reset_n), 
	.ddr3_we_n                      (ddr3_we_n),  
	.ddr3_dq                        (ddr3_dq),  
	.ddr3_dqs_n                     (ddr3_dqs_n),  
	.ddr3_dqs_p                     (ddr3_dqs_p),  
	.init_calib_complete            (init_calib_complete),  
	 
	.ddr3_cs_n                      (ddr3_cs_n),  
	.ddr3_dm                        (ddr3_dm),  
	.ddr3_odt                       (ddr3_odt),  
	// Application interface ports
	.ui_clk                         (ui_clk), 
	.ui_clk_sync_rst                (ui_clk_sync_rst),  // output			ui_clk_sync_rst
	.mmcm_locked                    (),  // output			mmcm_locked
	.aresetn                        (1'b1),  // input			aresetn
	.app_sr_req                     (1'b0),  // input			app_sr_req
	.app_ref_req                    (1'b0),  // input			app_ref_req
	.app_zq_req                     (1'b0),  // input			app_zq_req
	.app_sr_active                  (),  // output			app_sr_active
	.app_ref_ack                    (),  // output			app_ref_ack
	.app_zq_ack                     (),  // output			app_zq_ack
	// Slave Interface Write Address Ports
	.s_axi_awid                     (m_axi_awid),  // input [0:0]			s_axi_awid
	.s_axi_awaddr                   (m_axi_awaddr),  // input [29:0]			s_axi_awaddr
	.s_axi_awlen                    (m_axi_awlen),  // input [7:0]			s_axi_awlen
	.s_axi_awsize                   (m_axi_awsize),  // input [2:0]			s_axi_awsize
	.s_axi_awburst                  (m_axi_awburst),  // input [1:0]			s_axi_awburst
	.s_axi_awlock                   (m_axi_awlock),  // input [0:0]			s_axi_awlock
	.s_axi_awcache                  (m_axi_awcache),  // input [3:0]			s_axi_awcache
	.s_axi_awprot                   (m_axi_awprot),  // input [2:0]			s_axi_awprot
	.s_axi_awqos                    (m_axi_awqos),  // input [3:0]			s_axi_awqos
	.s_axi_awvalid                  (m_axi_awvalid),  // input			s_axi_awvalid
	.s_axi_awready                  (m_axi_awready),  // output			s_axi_awready
	// Slave Interface Write Data Ports
	.s_axi_wdata                    (m_axi_wdata),  // input [63:0]			s_axi_wdata
	.s_axi_wstrb                    (m_axi_wstrb),  // input [7:0]			s_axi_wstrb
	.s_axi_wlast                    (m_axi_wlast),  // input			s_axi_wlast
	.s_axi_wvalid                   (m_axi_wvalid),  // input			s_axi_wvalid
	.s_axi_wready                   (m_axi_wready),  // output			s_axi_wready
	// Slave Interface Write Response Ports
	.s_axi_bid                      (m_axi_bid),  // output [0:0]			s_axi_bid
	.s_axi_bresp                    (m_axi_bresp),  // output [1:0]			s_axi_bresp
	.s_axi_bvalid                   (m_axi_bvalid),  // output			s_axi_bvalid
	.s_axi_bready                   (m_axi_bready),  // input			s_axi_bready
	// Slave Interface Read Address Ports
	.s_axi_arid                     (m_axi_arid),  // input [0:0]			s_axi_arid
	.s_axi_araddr                   (m_axi_araddr),  // input [29:0]			s_axi_araddr
	.s_axi_arlen                    (m_axi_arlen),  // input [7:0]			s_axi_arlen
	.s_axi_arsize                   (m_axi_arsize),  // input [2:0]			s_axi_arsize
	.s_axi_arburst                  (m_axi_arburst),  // input [1:0]			s_axi_arburst
	.s_axi_arlock                   (m_axi_arlock),  // input [0:0]			s_axi_arlock
	.s_axi_arcache                  (m_axi_arcache),  // input [3:0]			s_axi_arcache
	.s_axi_arprot                   (m_axi_arprot),  // input [2:0]			s_axi_arprot
	.s_axi_arqos                    (m_axi_arqos),  // input [3:0]			s_axi_arqos
	.s_axi_arvalid                  (m_axi_arvalid),  // input			s_axi_arvalid
	.s_axi_arready                  (m_axi_arready),  // output			s_axi_arready
	// Slave Interface Read Data Ports
	.s_axi_rid                      (m_axi_rid),  // output [0:0]			s_axi_rid
	.s_axi_rdata                    (m_axi_rdata),  // output [63:0]			s_axi_rdata
	.s_axi_rresp                    (m_axi_rresp),  // output [1:0]			s_axi_rresp
	.s_axi_rlast                    (m_axi_rlast),  // output			s_axi_rlast
	.s_axi_rvalid                   (m_axi_rvalid),  // output			s_axi_rvalid
	.s_axi_rready                   (m_axi_rready),  // input			s_axi_rready
	// System Clock Ports
	.sys_clk_i                      (sys_clk),
	.sys_rst                        (sys_rst) // input sys_rst
);

axi_interconnect axi_interconnect_m0 
(
	.INTERCONNECT_ACLK               (s00_axi_aclk                         ),
	.INTERCONNECT_ARESETN            (~ui_clk_sync_rst                     ),
	.S00_AXI_ARESET_OUT_N            (                                     ),
	.S00_AXI_ACLK                    (s00_axi_aclk                         ),
	.S00_AXI_AWID                    (s00_axi_awid                         ),
	.S00_AXI_AWADDR                  (s00_axi_awaddr                       ),
	.S00_AXI_AWLEN                   (s00_axi_awlen                        ),
	.S00_AXI_AWSIZE                  (s00_axi_awsize                       ),
	.S00_AXI_AWBURST                 (s00_axi_awburst                      ),
	.S00_AXI_AWLOCK                  (s00_axi_awlock                       ),
	.S00_AXI_AWCACHE                 (s00_axi_awcache                      ),
	.S00_AXI_AWPROT                  (s00_axi_awprot                       ),
	.S00_AXI_AWQOS                   (s00_axi_awqos                        ),
	.S00_AXI_AWVALID                 (s00_axi_awvalid                      ),
	.S00_AXI_AWREADY                 (s00_axi_awready                      ),
	.S00_AXI_WDATA                   (s00_axi_wdata                        ),
	.S00_AXI_WSTRB                   (s00_axi_wstrb                        ),
	.S00_AXI_WLAST                   (s00_axi_wlast                        ),
	.S00_AXI_WVALID                  (s00_axi_wvalid                       ),
	.S00_AXI_WREADY                  (s00_axi_wready                       ),
	.S00_AXI_BID                     (s00_axi_bid                          ),
	.S00_AXI_BRESP                   (s00_axi_bresp                        ),
	.S00_AXI_BVALID                  (s00_axi_bvalid                       ),
	.S00_AXI_BREADY                  (s00_axi_bready                       ),
	.S00_AXI_ARID                    (s00_axi_arid                         ),
	.S00_AXI_ARADDR                  (s00_axi_araddr                       ),
	.S00_AXI_ARLEN                   (s00_axi_arlen                        ),
	.S00_AXI_ARSIZE                  (s00_axi_arsize                       ),
	.S00_AXI_ARBURST                 (s00_axi_arburst                      ),
	.S00_AXI_ARLOCK                  (s00_axi_arlock                       ),
	.S00_AXI_ARCACHE                 (s00_axi_arcache                      ),
	.S00_AXI_ARPROT                  (s00_axi_arprot                       ),
	.S00_AXI_ARQOS                   (s00_axi_arqos                        ),
	.S00_AXI_ARVALID                 (s00_axi_arvalid                      ),
	.S00_AXI_ARREADY                 (s00_axi_arready                      ),
	.S00_AXI_RID                     (s00_axi_rid                          ),
	.S00_AXI_RDATA                   (s00_axi_rdata                        ),
	.S00_AXI_RRESP                   (s00_axi_rresp                        ),
	.S00_AXI_RLAST                   (s00_axi_rlast                        ),
	.S00_AXI_RVALID                  (s00_axi_rvalid                       ),
	.S00_AXI_RREADY                  (s00_axi_rready                       ),
	
	.M00_AXI_ARESET_OUT_N            (                                     ),
	.M00_AXI_ACLK                    (ui_clk                               ),
	.M00_AXI_AWID                    (m_axi_awid                           ),
	.M00_AXI_AWADDR                  (m_axi_awaddr                         ),
	.M00_AXI_AWLEN                   (m_axi_awlen                          ),
	.M00_AXI_AWSIZE                  (m_axi_awsize                         ),
	.M00_AXI_AWBURST                 (m_axi_awburst                        ),
	.M00_AXI_AWLOCK                  (m_axi_awlock                         ),
	.M00_AXI_AWCACHE                 (m_axi_awcache                        ),
	.M00_AXI_AWPROT                  (m_axi_awprot                         ),
	.M00_AXI_AWQOS                   (m_axi_awqos                          ),
	.M00_AXI_AWVALID                 (m_axi_awvalid                        ),
	.M00_AXI_AWREADY                 (m_axi_awready                        ),
	.M00_AXI_WDATA                   (m_axi_wdata                          ),
	.M00_AXI_WSTRB                   (m_axi_wstrb                          ),
	.M00_AXI_WLAST                   (m_axi_wlast                          ),
	.M00_AXI_WVALID                  (m_axi_wvalid                         ),
	.M00_AXI_WREADY                  (m_axi_wready                         ),
	.M00_AXI_BID                     (m_axi_bid                            ),
	.M00_AXI_BRESP                   (m_axi_bresp                          ),
	.M00_AXI_BVALID                  (m_axi_bvalid                         ),
	.M00_AXI_BREADY                  (m_axi_bready                         ),
	.M00_AXI_ARID                    (m_axi_arid                           ),
	.M00_AXI_ARADDR                  (m_axi_araddr                         ),
	.M00_AXI_ARLEN                   (m_axi_arlen                          ),
	.M00_AXI_ARSIZE                  (m_axi_arsize                         ),
	.M00_AXI_ARBURST                 (m_axi_arburst                        ),
	.M00_AXI_ARLOCK                  (m_axi_arlock                         ),
	.M00_AXI_ARCACHE                 (m_axi_arcache                        ),
	.M00_AXI_ARPROT                  (m_axi_arprot                         ),
	.M00_AXI_ARQOS                   (m_axi_arqos                          ),
	.M00_AXI_ARVALID                 (m_axi_arvalid                        ),
	.M00_AXI_ARREADY                 (m_axi_arready                        ),
	.M00_AXI_RID                     (m_axi_rid                            ),
	.M00_AXI_RDATA                   (m_axi_rdata                          ),
	.M00_AXI_RRESP                   (m_axi_rresp                          ),
	.M00_AXI_RLAST                   (m_axi_rlast                          ),
	.M00_AXI_RVALID                  (m_axi_rvalid                         ),
	.M00_AXI_RREADY                  (m_axi_rready                         )
);

aq_axi_master u_aq_axi_master
	(
	  .ARESETN                     (~ui_clk_sync_rst                          ),
	  .ACLK                        (s00_axi_aclk                              ),
	  .M_AXI_AWID                  (s00_axi_awid                              ),
	  .M_AXI_AWADDR                (s00_axi_awaddr                            ),
	  .M_AXI_AWLEN                 (s00_axi_awlen                             ),
	  .M_AXI_AWSIZE                (s00_axi_awsize                            ),
	  .M_AXI_AWBURST               (s00_axi_awburst                           ),
	  .M_AXI_AWLOCK                (s00_axi_awlock                            ),
	  .M_AXI_AWCACHE               (s00_axi_awcache                           ),
	  .M_AXI_AWPROT                (s00_axi_awprot                            ),
	  .M_AXI_AWQOS                 (s00_axi_awqos                             ),
	  .M_AXI_AWUSER                (s00_axi_awuser                            ),
	  .M_AXI_AWVALID               (s00_axi_awvalid                           ),
	  .M_AXI_AWREADY               (s00_axi_awready                           ),
	  .M_AXI_WDATA                 (s00_axi_wdata                             ),
	  .M_AXI_WSTRB                 (s00_axi_wstrb                             ),
	  .M_AXI_WLAST                 (s00_axi_wlast                             ),
	  .M_AXI_WUSER                 (s00_axi_wuser                             ),
	  .M_AXI_WVALID                (s00_axi_wvalid                            ),
	  .M_AXI_WREADY                (s00_axi_wready                            ),
	  .M_AXI_BID                   (s00_axi_bid                               ),
	  .M_AXI_BRESP                 (s00_axi_bresp                             ),
	  .M_AXI_BUSER                 (s00_axi_buser                             ),
	  .M_AXI_BVALID                (s00_axi_bvalid                            ),
	  .M_AXI_BREADY                (s00_axi_bready                            ),
	  .M_AXI_ARID                  (s00_axi_arid                              ),
	  .M_AXI_ARADDR                (s00_axi_araddr                            ),
	  .M_AXI_ARLEN                 (s00_axi_arlen                             ),
	  .M_AXI_ARSIZE                (s00_axi_arsize                            ),
	  .M_AXI_ARBURST               (s00_axi_arburst                           ),
	  .M_AXI_ARLOCK                (s00_axi_arlock                            ),
	  .M_AXI_ARCACHE               (s00_axi_arcache                           ),
	  .M_AXI_ARPROT                (s00_axi_arprot                            ),
	  .M_AXI_ARQOS                 (s00_axi_arqos                             ),
	  .M_AXI_ARUSER                (s00_axi_aruser                            ),
	  .M_AXI_ARVALID               (s00_axi_arvalid                           ),
	  .M_AXI_ARREADY               (s00_axi_arready                           ),
	  .M_AXI_RID                   (s00_axi_rid                               ),
	  .M_AXI_RDATA                 (s00_axi_rdata                             ),
	  .M_AXI_RRESP                 (s00_axi_rresp                             ),
	  .M_AXI_RLAST                 (s00_axi_rlast                             ),
	  .M_AXI_RUSER                 (s00_axi_ruser                             ),
	  .M_AXI_RVALID                (s00_axi_rvalid                            ),
	  .M_AXI_RREADY                (s00_axi_rready                            ),
	  .MASTER_RST                  (1'b0                                     ),
	  .WR_START                    (wr_burst_req                             ),
	  .WR_ADRS                     ({wr_burst_addr,3'd0}                     ),
	  .WR_LEN                      ({wr_burst_len,3'd0}                      ),
	  .WR_READY                    (                                         ),
	  .WR_FIFO_RE                  (wr_burst_data_req                        ),
	  .WR_FIFO_EMPTY               (1'b0                                     ),
	  .WR_FIFO_AEMPTY              (1'b0                                     ),
	  .WR_FIFO_DATA                (wr_burst_data                            ),
	  .WR_DONE                     (wr_burst_finish                          ),
	  .RD_START                    (rd_burst_req                             ),
	  .RD_ADRS                     ({rd_burst_addr,3'd0}                     ),
	  .RD_LEN                      ({rd_burst_len,3'd0}                      ),
	  .RD_READY                    (                                         ),
	  .RD_FIFO_WE                  (rd_burst_data_valid                      ),
	  .RD_FIFO_FULL                (1'b0                                     ),
	  .RD_FIFO_AFULL               (1'b0                                     ),
	  .RD_FIFO_DATA                (rd_burst_data                            ),
	  .RD_DONE                     (rd_burst_finish                          ),
	  .DEBUG                       (                                         )
	);
	
video_write_req_gen video_write_req_gen_m0(
	.rst                        (~rst_n                   ),
	.pclk                       (vin_clk                  ),
	.video_vsync                (vin_vs                   ),
	.write_req                  (write_req                ),
	.write_addr_index           (write_addr_index         ),
	.read_addr_index            (read_addr_index          ),
	.write_req_ack              (write_req_ack            )
);	
//video output timing generator and generate a frame read data request
video_timing_data video_timing_data_m0
(
	.video_clk                  (video_clk                ),
	.rst                        (~rst_n                   ),
	.read_req                   (read_req                 ),
	.read_req_ack               (read_req_ack             ),
	.read_en                    (read_en                  ),
	.read_data                  (read_data                ),
	.hs                         (hs                       ),
	.vs                         (vs                       ),
	.de                         (de                       ),
	.vout_data                  (vout_data                )
);	
//video frame data read-write control
frame_read_write frame_read_write_m0
(
	.rst                        (~rst_n                   ),
	.mem_clk                    (ext_mem_clk              ),
	.rd_burst_req               (rd_burst_req             ),
	.rd_burst_len               (rd_burst_len             ),
	.rd_burst_addr              (rd_burst_addr            ),
	.rd_burst_data_valid        (rd_burst_data_valid      ),
	.rd_burst_data              (rd_burst_data            ),
	.rd_burst_finish            (rd_burst_finish          ),
	.read_clk                   (video_clk                ),
	.read_req                   (read_req                 ),
	.read_req_ack               (read_req_ack             ),
	.read_finish                (                         ),
	.read_addr_0                (24'd0                    ), //The first frame address is 0
	.read_addr_1                (24'd2073600              ), //The second frame address is 24'd2073600 ,large enough address space for one frame of video
	.read_addr_2                (24'd4147200              ),
	.read_addr_3                (24'd6220800              ),
	.read_addr_index            (read_addr_index          ),
	.read_len                   (24'd1036800              ), //frame size
	.read_en                    (read_en                  ),
	.read_data                  (read_data                ),

	.wr_burst_req               (wr_burst_req             ),
	.wr_burst_len               (wr_burst_len             ),
	.wr_burst_addr              (wr_burst_addr            ),
	.wr_burst_data_req          (wr_burst_data_req        ),
	.wr_burst_data              (wr_burst_data            ),
	.wr_burst_finish            (wr_burst_finish          ),
	.write_clk                  (vin_clk                  ),
	.write_req                  (write_req                ),
	.write_req_ack              (write_req_ack            ),
	.write_finish               (                         ),
	.write_addr_0               (24'd0                    ),
	.write_addr_1               (24'd2073600              ),
	.write_addr_2               (24'd4147200              ),
	.write_addr_3               (24'd6220800              ),
	.write_addr_index           (write_addr_index         ),
	.write_len                  (24'd1036800              ), //frame size
	.write_en                   (write_en                 ),
	.write_data                 (write_data               )
);
endmodule
