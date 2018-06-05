//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
//Date        : Fri Nov 10 13:44:56 2017
//Host        : ALINX000008-PC running 64-bit Service Pack 1  (build 7601)
//Command     : generate_target PCIe_wrapper.bd
//Design      : PCIe_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module PCIe_wrapper
   (DDR3_addr,
    DDR3_ba,
    DDR3_cas_n,
    DDR3_ck_n,
    DDR3_ck_p,
    DDR3_cke,
    DDR3_cs_n,
    DDR3_dm,
    DDR3_dq,
    DDR3_dqs_n,
    DDR3_dqs_p,
    DDR3_odt,
    DDR3_ras_n,
    DDR3_reset_n,
    DDR3_we_n,
    S0_AXI_araddr,
    S0_AXI_arburst,
    S0_AXI_arcache,
    S0_AXI_arid,
    S0_AXI_arlen,
    S0_AXI_arlock,
    S0_AXI_arprot,
    S0_AXI_arqos,
    S0_AXI_arready,
    S0_AXI_arregion,
    S0_AXI_arsize,
    S0_AXI_arvalid,
    S0_AXI_rdata,
    S0_AXI_rid,
    S0_AXI_rlast,
    S0_AXI_rready,
    S0_AXI_rresp,
    S0_AXI_rvalid,
    UI_CLK,
    clk_100M,
    init_ddr,
    locked,
    msi_enable,
    pci_exp_rxn,
    pci_exp_rxp,
    pci_exp_txn,
    pci_exp_txp,
    sys_clk_clk_n,
    sys_clk_clk_p,
    sys_ddr_clk_n,
    sys_ddr_clk_p,
    sys_rst,
    sys_rst_n,
    user_lnk_up,
    usr_irq_req);
  output [14:0]DDR3_addr;
  output [2:0]DDR3_ba;
  output DDR3_cas_n;
  output [0:0]DDR3_ck_n;
  output [0:0]DDR3_ck_p;
  output [0:0]DDR3_cke;
  output [0:0]DDR3_cs_n;
  output [3:0]DDR3_dm;
  inout [31:0]DDR3_dq;
  inout [3:0]DDR3_dqs_n;
  inout [3:0]DDR3_dqs_p;
  output [0:0]DDR3_odt;
  output DDR3_ras_n;
  output DDR3_reset_n;
  output DDR3_we_n;
  input [31:0]S0_AXI_araddr;
  input [1:0]S0_AXI_arburst;
  input [3:0]S0_AXI_arcache;
  input [5:0]S0_AXI_arid;
  input [7:0]S0_AXI_arlen;
  input [0:0]S0_AXI_arlock;
  input [2:0]S0_AXI_arprot;
  input [3:0]S0_AXI_arqos;
  output S0_AXI_arready;
  input [3:0]S0_AXI_arregion;
  input [2:0]S0_AXI_arsize;
  input S0_AXI_arvalid;
  output [63:0]S0_AXI_rdata;
  output [5:0]S0_AXI_rid;
  output S0_AXI_rlast;
  input S0_AXI_rready;
  output [1:0]S0_AXI_rresp;
  output S0_AXI_rvalid;
  output UI_CLK;
  output clk_100M;
  output init_ddr;
  output locked;
  output msi_enable;
  input [3:0]pci_exp_rxn;
  input [3:0]pci_exp_rxp;
  output [3:0]pci_exp_txn;
  output [3:0]pci_exp_txp;
  input [0:0]sys_clk_clk_n;
  input [0:0]sys_clk_clk_p;
  input sys_ddr_clk_n;
  input sys_ddr_clk_p;
  input sys_rst;
  input sys_rst_n;
  output user_lnk_up;
  input [2:0]usr_irq_req;

  wire [14:0]DDR3_addr;
  wire [2:0]DDR3_ba;
  wire DDR3_cas_n;
  wire [0:0]DDR3_ck_n;
  wire [0:0]DDR3_ck_p;
  wire [0:0]DDR3_cke;
  wire [0:0]DDR3_cs_n;
  wire [3:0]DDR3_dm;
  wire [31:0]DDR3_dq;
  wire [3:0]DDR3_dqs_n;
  wire [3:0]DDR3_dqs_p;
  wire [0:0]DDR3_odt;
  wire DDR3_ras_n;
  wire DDR3_reset_n;
  wire DDR3_we_n;
  wire [31:0]S0_AXI_araddr;
  wire [1:0]S0_AXI_arburst;
  wire [3:0]S0_AXI_arcache;
  wire [5:0]S0_AXI_arid;
  wire [7:0]S0_AXI_arlen;
  wire [0:0]S0_AXI_arlock;
  wire [2:0]S0_AXI_arprot;
  wire [3:0]S0_AXI_arqos;
  wire S0_AXI_arready;
  wire [3:0]S0_AXI_arregion;
  wire [2:0]S0_AXI_arsize;
  wire S0_AXI_arvalid;
  wire [63:0]S0_AXI_rdata;
  wire [5:0]S0_AXI_rid;
  wire S0_AXI_rlast;
  wire S0_AXI_rready;
  wire [1:0]S0_AXI_rresp;
  wire S0_AXI_rvalid;
  wire UI_CLK;
  wire clk_100M;
  wire init_ddr;
  wire locked;
  wire msi_enable;
  wire [3:0]pci_exp_rxn;
  wire [3:0]pci_exp_rxp;
  wire [3:0]pci_exp_txn;
  wire [3:0]pci_exp_txp;
  wire [0:0]sys_clk_clk_n;
  wire [0:0]sys_clk_clk_p;
  wire sys_ddr_clk_n;
  wire sys_ddr_clk_p;
  wire sys_rst;
  wire sys_rst_n;
  wire user_lnk_up;
  wire [2:0]usr_irq_req;

  PCIe PCIe_i
       (.DDR3_addr(DDR3_addr),
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
        .usr_irq_req(usr_irq_req));
endmodule
