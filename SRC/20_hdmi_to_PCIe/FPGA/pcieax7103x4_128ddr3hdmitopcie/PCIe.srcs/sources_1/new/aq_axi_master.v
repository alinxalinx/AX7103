/*
 * Copyright (C)2014-2015 AQUAXIS TECHNOLOGY.
 *  Don't remove this header. 
 * When you use this source, there is a need to inherit this header.
 *
 * License
 *  For no commercial -
 *   License:     The Open Software License 3.0
 *   License URI: http://www.opensource.org/licenses/OSL-3.0
 *
 *  For commmercial -
 *   License:     AQUAXIS License 1.0
 *   License URI: http://www.aquaxis.com/licenses
 *
 * For further information please contact.
 *	URI:    http://www.aquaxis.com/
 *	E-Mail: info(at)aquaxis.com
 */
 
 //////////////////////////////////////////////////////////////////////////////////
// Company: ALINXÈªëÈáë
// Engineer: ËÄÅÊ¢Ö
// 
// Create Date: 2016/11/17 10:27:06
// Design Name: 
// Module Name: mem_test
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
module aq_axi_master(
  // Reset, Clock
  input           ARESETN,
  input           ACLK,

  // Master Write Address
  output [0:0]  M_AXI_AWID,
  output [31:0] M_AXI_AWADDR,
  output [7:0]  M_AXI_AWLEN,    // Burst Length: 0-255
  output [2:0]  M_AXI_AWSIZE,   // Burst Size: Fixed 2'b011
  output [1:0]  M_AXI_AWBURST,  // Burst Type: Fixed 2'b01(Incremental Burst)
  output        M_AXI_AWLOCK,   // Lock: Fixed 2'b00
  output [3:0]  M_AXI_AWCACHE,  // Cache: Fiex 2'b0011
  output [2:0]  M_AXI_AWPROT,   // Protect: Fixed 2'b000
  output [3:0]  M_AXI_AWQOS,    // QoS: Fixed 2'b0000
  output [0:0]  M_AXI_AWUSER,   // User: Fixed 32'd0
  output        M_AXI_AWVALID,
  input         M_AXI_AWREADY,

  // Master Write Data
  output [63:0] M_AXI_WDATA,
  output [7:0]  M_AXI_WSTRB,
  output        M_AXI_WLAST,
  output [0:0]  M_AXI_WUSER,
  output        M_AXI_WVALID,
  input         M_AXI_WREADY,

  // Master Write Response
  input [0:0]   M_AXI_BID,
  input [1:0]   M_AXI_BRESP,
  input [0:0]   M_AXI_BUSER,
  input         M_AXI_BVALID,
  output        M_AXI_BREADY,
   
  // Local Bus
  input         MASTER_RST,
  
  input         WR_START,
  input [31:0]  WR_ADRS,
  input [31:0]  WR_LEN, 
  output        WR_READY,
  output        WR_FIFO_RE,
  input         WR_FIFO_EMPTY,
  input         WR_FIFO_AEMPTY,
  input [63:0]  WR_FIFO_DATA,
  output        WR_DONE,

  input         RD_START,
  input [31:0]  RD_ADRS,
  input [31:0]  RD_LEN, 
  output        RD_READY,
  output        RD_FIFO_WE,
  input         RD_FIFO_FULL,
  input         RD_FIFO_AFULL,
  output [63:0] RD_FIFO_DATA,
  output        RD_DONE,

  output [31:0] DEBUG
);

  localparam S_WR_IDLE  = 3'd0;
  localparam S_WA_WAIT  = 3'd1;
  localparam S_WA_START = 3'd2;
  localparam S_WD_WAIT  = 3'd3;
  localparam S_WD_PROC  = 3'd4;
  localparam S_WR_WAIT  = 3'd5;
  localparam S_WR_DONE  = 3'd6;
  
  reg [2:0]   wr_state;
  reg [31:0]  reg_wr_adrs;
  reg [31:0]  reg_wr_len;
  reg         reg_awvalid, reg_wvalid, reg_w_last;
  reg [7:0]   reg_w_len;
  reg [7:0]   reg_w_stb;
  reg [1:0]   reg_wr_status;
  reg [3:0]   reg_w_count, reg_r_count;

  reg [7:0]   rd_chkdata, wr_chkdata;
  reg [1:0]   resp;
  reg rd_first_data;
  reg rd_fifo_enable;
  reg[31:0] rd_fifo_cnt;
assign WR_DONE = (wr_state == S_WR_DONE);



assign WR_FIFO_RE         = rd_first_data | (reg_wvalid & ~WR_FIFO_EMPTY & M_AXI_WREADY & rd_fifo_enable);
always @(posedge ACLK or negedge ARESETN)//fifo cnotrl
begin
	if(!ARESETN)
		rd_fifo_cnt <= 32'd0;
	else if(WR_FIFO_RE)
		rd_fifo_cnt <= rd_fifo_cnt + 32'd1;
	else if(wr_state == S_WR_IDLE)
		rd_fifo_cnt <= 32'd0;	
end

always @(posedge ACLK or negedge ARESETN)
begin
	if(!ARESETN)
		rd_fifo_enable <= 1'b0;
	else if(wr_state == S_WR_IDLE && WR_START)
		rd_fifo_enable <= 1'b1;
	else if(WR_FIFO_RE && (rd_fifo_cnt == RD_LEN[31:3] - 32'd1) )	
		rd_fifo_enable <= 1'b0;		
end
  // Write State
  always @(posedge ACLK or negedge ARESETN) begin
    if(!ARESETN) begin
      wr_state            <= S_WR_IDLE;
      reg_wr_adrs[31:0]   <= 32'd0;
      reg_wr_len[31:0]    <= 32'd0;
      reg_awvalid         <= 1'b0;
      reg_wvalid          <= 1'b0;
      reg_w_last          <= 1'b0;
      reg_w_len[7:0]      <= 8'd0;
      reg_w_stb[7:0]      <= 8'd0;
      reg_wr_status[1:0]  <= 2'd0;
      reg_w_count[3:0]    <= 4'd0;
      reg_r_count[3:0]  <= 4'd0;
      wr_chkdata          <= 8'd0;
      rd_chkdata <= 8'd0;
      resp <= 2'd0;
	  rd_first_data <= 1'b0;
  end else begin
    if(MASTER_RST) begin
      wr_state <= S_WR_IDLE;
    end else begin
      case(wr_state)
        S_WR_IDLE: begin
          if(WR_START) begin
            wr_state          <= S_WA_WAIT;
            reg_wr_adrs[31:0] <= WR_ADRS[31:0];
            reg_wr_len[31:0]  <= WR_LEN[31:0] -32'd1;
			rd_first_data <= 1'b1;
          end
          reg_awvalid         <= 1'b0;
          reg_wvalid          <= 1'b0;
          reg_w_last          <= 1'b0;
          reg_w_len[7:0]      <= 8'd0;
          reg_w_stb[7:0]      <= 8'd0;
          reg_wr_status[1:0]  <= 2'd0;
        end
        S_WA_WAIT: begin//µÿ÷∑…Ë÷√Ω◊∂Œ
          if(!WR_FIFO_AEMPTY | (reg_wr_len[31:11] == 21'd0)) begin
            wr_state          <= S_WA_START;
          end
		  rd_first_data <= 1'b0;
        end
        S_WA_START: begin
          wr_state            <= S_WD_WAIT;
          reg_awvalid         <= 1'b1;
          reg_wr_len[31:11]    <= reg_wr_len[31:11] - 21'd1;
          if(reg_wr_len[31:11] != 21'd0) begin
            reg_w_len[7:0]  <= 8'hFF;//len 256
            reg_w_last      <= 1'b0;
            reg_w_stb[7:0]  <= 8'hFF;
          end else begin
            reg_w_len[7:0]  <= reg_wr_len[10:3];
            reg_w_last      <= 1'b1;
            reg_w_stb[7:0]  <= 8'hFF;
          end
        end
        S_WD_WAIT: begin
          if(M_AXI_AWREADY) begin//
            wr_state        <= S_WD_PROC;
            reg_awvalid     <= 1'b0;
            reg_wvalid      <= 1'b1;
          end
        end
        S_WD_PROC: begin
          if(M_AXI_WREADY & ~WR_FIFO_EMPTY) begin//
            if(reg_w_len[7:0] == 8'd0) begin
              wr_state        <= S_WR_WAIT;
              reg_wvalid      <= 1'b0;
              reg_w_stb[7:0]  <= 8'h00;
            end else begin
              reg_w_len[7:0]  <= reg_w_len[7:0] -8'd1;
            end
          end
        end
        S_WR_WAIT: begin
          if(M_AXI_BVALID) begin
            reg_wr_status[1:0]  <= reg_wr_status[1:0] | M_AXI_BRESP[1:0];
            if(reg_w_last) begin
              wr_state          <= S_WR_DONE;
            end else begin
              wr_state          <= S_WA_WAIT;
              reg_wr_adrs[31:0] <= reg_wr_adrs[31:0] + 32'd2048;
            end
          end
        end
        S_WR_DONE: begin
            wr_state <= S_WR_IDLE;
          end
        
        default: begin
          wr_state <= S_WR_IDLE;
        end
      endcase
      end
    end
  end
   
  assign M_AXI_AWID         = 1'b0;
  assign M_AXI_AWADDR[31:0] = reg_wr_adrs[31:0];
  assign M_AXI_AWLEN[7:0]   = reg_w_len[7:0];
  assign M_AXI_AWSIZE[2:0]  = 2'b011;
  assign M_AXI_AWBURST[1:0] = 2'b01;
  assign M_AXI_AWLOCK       = 1'b0;//
  assign M_AXI_AWCACHE[3:0] = 4'b0011;
  assign M_AXI_AWPROT[2:0]  = 3'b000;
  assign M_AXI_AWQOS[3:0]   = 4'b0000;
  assign M_AXI_AWUSER[0]    = 1'b1;
  assign M_AXI_AWVALID      = reg_awvalid;

  assign M_AXI_WDATA[63:0]  = WR_FIFO_DATA[63:0];
  assign M_AXI_WSTRB[7:0]   = (reg_wvalid & ~WR_FIFO_EMPTY)?8'hFF:8'h00;
  assign M_AXI_WLAST        = (reg_w_len[7:0] == 8'd0)?1'b1:1'b0;
  assign M_AXI_WUSER        = 1;
  assign M_AXI_WVALID       = reg_wvalid & ~WR_FIFO_EMPTY;

  assign M_AXI_BREADY       = M_AXI_BVALID;

  assign WR_READY           = (wr_state == S_WR_IDLE)?1'b1:1'b0;
  
endmodule

