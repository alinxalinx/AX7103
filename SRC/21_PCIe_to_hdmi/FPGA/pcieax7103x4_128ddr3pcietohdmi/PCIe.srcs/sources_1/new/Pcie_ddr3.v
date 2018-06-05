`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/08/30 09:45:05
// Design Name: 
// Module Name: Pcie_ddr3
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


module Pcie_ddr3(
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
	output[23:0]                       vout_data,
    output [14:0]                      DDR3_addr,
    output [2:0]                       DDR3_ba,
    output                             DDR3_cas_n,
    output [0:0]                       DDR3_ck_n,
    output [0:0]                       DDR3_ck_p,
    output [0:0]                       DDR3_cke,
    output [0:0]                       DDR3_cs_n,
    output [3:0]                       DDR3_dm,
    inout [31:0]                       DDR3_dq,
    inout [3:0]                        DDR3_dqs_n,
    inout [3:0]                        DDR3_dqs_p,
    output [0:0]                       DDR3_odt,
    output                             DDR3_ras_n,
    output                             DDR3_reset_n,
    output                             DDR3_we_n,
    input [3:0]                        pci_exp_rxn,
    input [3:0]                        pci_exp_rxp,
    output [3:0]                       pci_exp_txn,
    output [3:0]                       pci_exp_txp,
    input [0:0]                        sys_clk_clk_n,
    input [0:0]                        sys_clk_clk_p,
    input                              sys_ddr_clk_n,
    input                              sys_ddr_clk_p,
    input                              sys_rst,
    input                              sys_rst_n,
    output                             init_ddr,
    output                             msi_enable,
    output                             user_lnk_up
        );

    wire [31:0]S0_AXI_araddr;
    wire [1:0]S0_AXI_arburst;
    wire [3:0]S0_AXI_arcache;
    wire [0:0]S0_AXI_arid;
    wire [7:0]S0_AXI_arlen;
    wire [0:0]S0_AXI_arlock;
    wire [2:0]S0_AXI_arprot;
    wire [3:0]S0_AXI_arqos;
    wire S0_AXI_arready;
    wire [3:0]S0_AXI_arregion;
    wire [2:0]S0_AXI_arsize;
    wire S0_AXI_arvalid;
    wire [31:0]S0_AXI_awaddr;
    wire [1:0]S0_AXI_awburst;
    wire [3:0]S0_AXI_awcache;
    wire [0:0]S0_AXI_awid;
    wire [7:0]S0_AXI_awlen;
    wire [0:0]S0_AXI_awlock;
    wire [2:0]S0_AXI_awprot;
    wire [3:0]S0_AXI_awqos;
    wire S0_AXI_awready;
    wire [3:0]S0_AXI_awregion;
    wire [2:0]S0_AXI_awsize;
    wire S0_AXI_awvalid;
    wire [5:0]S0_AXI_bid;
    wire S0_AXI_bready;
    wire [1:0]S0_AXI_bresp;
    wire S0_AXI_bvalid;
    wire [63:0]S0_AXI_rdata;
    wire [5:0]S0_AXI_rid;
    wire S0_AXI_rlast;
    wire S0_AXI_rready;
    wire [1:0]S0_AXI_rresp;
    wire S0_AXI_rvalid;
    wire [63:0]S0_AXI_wdata;
    wire S0_AXI_wlast;
    wire S0_AXI_wready;
    wire [7:0]S0_AXI_wstrb;
    wire S0_AXI_wvalid;
    wire UI_CLK;
    wire rst_n;    
    wire   clk_100M;//用于HDMI
    wire locked; 
    wire wr_burst_data_req;
    wire wr_burst_finish;
    wire rd_burst_finish;
    wire rd_burst_req;
    wire wr_burst_req;
    wire[9:0] rd_burst_len;
    wire[9:0] wr_burst_len;
    wire[31:0] rd_burst_addr;
    wire[31:0] wr_burst_addr;
    wire rd_burst_data_valid;
    wire[63 : 0] rd_burst_data;
    wire[63 : 0] wr_burst_data;
    wire read_finish;
    wire hs;
    wire vs;
    wire de;
    reg  vin_de_d0;
    reg[23:0] vin_data_d0;
    wire read_req;
    wire  read_req_ack;
    wire  read_en;
    wire[31:0] read_data;
    wire write_en;
    wire[31:0] write_data;
    wire write_req;
    wire write_req_ack;
    wire ext_mem_clk;       //external memory clock
    wire video_clk;         //video pixel clock
    
    wire[1:0] write_addr_index;
    wire[1:0] read_addr_index;
    wire[9:0] lut_index;
    wire[31:0] lut_data;
    wire s00_axi_aclk;
   assign vout_hs = hs;
    assign vout_vs = vs;
    assign vout_de = de;
    assign vout_clk = UI_CLK;
    assign ext_mem_clk = UI_CLK;
   // assign fan_pwm = 1'b0;
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
    //************************************************
    /**********************************************/
    reg[31:0] timer;
    reg  flag;
    always@(posedge clk_100M)//?ui_CLK
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
        .clk                        (clk_100M                 ),
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
    /***********************************************/
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
        .video_clk                  (UI_CLK               ),
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
        .rd_burst_data              ({rd_burst_data[31:0],rd_burst_data[63:32]}),
        .rd_burst_finish            (rd_burst_finish          ),
        .read_clk                   (UI_CLK                   ),
        .read_req                   (read_req                 ),
        .read_req_ack               (read_req_ack             ),
        .read_finish                (  read_finish            ),
        .read_addr_0                (24'd8294400                    ), //The first frame address is 0
        .read_addr_1                (24'd10368000              ), //The second frame address is 24'd2073600 ,large enough address space for one frame of video
        .read_addr_2                (24'd12441600              ),//64位
        .read_addr_3                (24'd14515200              ),//64位
        .read_addr_index            (0        ),
        .read_len                   (24'd1036800              ), //frame size
        .read_en                    (read_en                  ),
        .read_data                  (read_data                ),
    
        .wr_burst_req               (wr_burst_req             ),
        .wr_burst_len               (wr_burst_len             ),
        .wr_burst_addr              (wr_burst_addr            ),
        .wr_burst_data_req          (1'b0       ),
        .wr_burst_data              (          ),
        .wr_burst_finish            (wr_burst_finish          ),
        .write_clk                  (vin_clk                  ),
        .write_req                  (write_req                ),
        .write_req_ack              (write_req_ack            ),
        .write_finish               (                         ),
        .write_addr_0               (24'd0                    ),
        .write_addr_1               (24'd2073600              ),
        .write_addr_2               (24'd4147200              ),
        .write_addr_3               (24'd6220800              ),
         .write_addr_index           (1         ),
        .write_len                  (24'd1036800              ), //frame size
        .write_en                   (write_en                 ),
        .write_data                 (write_data               )
    );
  
    aq_axi_master u_aq_axi_master
        (
          .ARESETN(rst_n),
          .ACLK(UI_CLK),
          
        
          .M_AXI_ARID(S0_AXI_arid),
          .M_AXI_ARADDR(S0_AXI_araddr),
          .M_AXI_ARLEN(S0_AXI_arlen),
          .M_AXI_ARSIZE(S0_AXI_arsize),
          .M_AXI_ARBURST(S0_AXI_arburst),
          .M_AXI_ARLOCK(S0_AXI_arlock),
          .M_AXI_ARCACHE(S0_AXI_arcache),
          .M_AXI_ARPROT(S0_AXI_arprot),
          .M_AXI_ARQOS(S0_AXI_arqos),
          .M_AXI_ARUSER(0),
          .M_AXI_ARVALID(S0_AXI_arvalid),
          .M_AXI_ARREADY(S0_AXI_arready),
          
          .M_AXI_RID(S0_AXI_rid),
          .M_AXI_RDATA(S0_AXI_rdata),
          .M_AXI_RRESP(S0_AXI_rresp),
          .M_AXI_RLAST(S0_AXI_rlast),
          .M_AXI_RUSER(0),
          .M_AXI_RVALID(S0_AXI_rvalid),
          .M_AXI_RREADY(S0_AXI_rready),
          
          .MASTER_RST(1'b0),
          
          .WR_START(wr_burst_req),
          .WR_ADRS({1'b0,wr_burst_addr[24:0],3'd0}),
          .WR_LEN({wr_burst_len,3'd0}), 
          .WR_READY(),
          .WR_FIFO_RE(wr_burst_data_req),
          .WR_FIFO_EMPTY(1'b0),
          .WR_FIFO_AEMPTY(1'b0),      
         .WR_FIFO_DATA(64'h00000000),
          .WR_DONE(wr_burst_finish),
          
          .RD_START(rd_burst_req),
          .RD_ADRS({1'b0,rd_burst_addr[24:0],3'd0}),
          .RD_LEN({rd_burst_len,3'd0}), 
          .RD_READY(),
          .RD_FIFO_WE(rd_burst_data_valid),
          .RD_FIFO_FULL(1'b0),
          .RD_FIFO_AFULL(1'b0),
          .RD_FIFO_DATA(rd_burst_data),
          .RD_DONE(rd_burst_finish),
          .DEBUG()                                         
        ); 
  PCIe_wrapper u_PCIe_wrapper(
          .DDR3_addr(DDR3_addr),
          .DDR3_ba(DDR3_ba),
          .DDR3_cas_n(DDR3_cas_n),
          .DDR3_ck_n(DDR3_ck_n),
          .DDR3_ck_p(DDR3_ck_p),
          .DDR3_cke(DDR3_cke),
          .DDR3_cs_n(DDR3_cs_n),
          .DDR3_dm(DDR3_dm),
          .DDR3_dq(DDR3_dq),
          .DDR3_dqs_n(DDR3_dqs_n),
          .DDR3_dqs_p(DDR3_dqs_p),
          .DDR3_odt(DDR3_odt),
          .DDR3_ras_n(DDR3_ras_n),
          .DDR3_reset_n(DDR3_reset_n),
          .DDR3_we_n(DDR3_we_n),
          .S0_AXI_araddr(S0_AXI_araddr),
          .S0_AXI_arburst(S0_AXI_arburst),
          .S0_AXI_arcache(S0_AXI_arcache),
          .S0_AXI_arid(S0_AXI_arid),
          .S0_AXI_arlen(S0_AXI_arlen),
          .S0_AXI_arlock(S0_AXI_arlock),
          .S0_AXI_arprot(S0_AXI_arprot),
          .S0_AXI_arqos(S0_AXI_arqos),
          .S0_AXI_arready(S0_AXI_arready),
          .S0_AXI_arregion(S0_AXI_arregion),
          .S0_AXI_arsize(S0_AXI_arsize),
          .S0_AXI_arvalid(S0_AXI_arvalid),
          .S0_AXI_rdata(S0_AXI_rdata),
          .S0_AXI_rid(S0_AXI_rid),
          .S0_AXI_rlast(S0_AXI_rlast),
          .S0_AXI_rready(S0_AXI_rready),
          .S0_AXI_rresp(S0_AXI_rresp),
          .S0_AXI_rvalid(S0_AXI_rvalid),     
          .UI_CLK(UI_CLK),
          .clk_100M(clk_100M),
           .init_ddr(init_ddr),
          .locked(locked),
            .msi_enable(msi_enable),
          .pci_exp_rxn(pci_exp_rxn),
          .pci_exp_rxp(pci_exp_rxp),
          .pci_exp_txn(pci_exp_txn),
          .pci_exp_txp(pci_exp_txp),
          .sys_clk_clk_n(sys_clk_clk_n),
          .sys_clk_clk_p(sys_clk_clk_p),
          .sys_ddr_clk_n(sys_ddr_clk_n),
          .sys_ddr_clk_p(sys_ddr_clk_p),
          .sys_rst(sys_rst),
          .sys_rst_n(sys_rst_n),
           .user_lnk_up(user_lnk_up),
           .usr_irq_req({1'b0,write_addr_index})
          );
endmodule
