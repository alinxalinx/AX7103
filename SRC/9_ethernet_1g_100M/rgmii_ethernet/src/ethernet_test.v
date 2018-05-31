`timescale 1ns / 1ps  
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    ethernet_test 
//////////////////////////////////////////////////////////////////////////////////
module ethernet_test(
   input sys_clk,      // ¿ª·¢°åÉÏ²î·ÖÊäÈëÊ±ÖÓ200Mhz
   input key1,

	output e_reset,
	output e_mdc,
	inout  e_mdio,

	output[3:0] rgmii_txd,
	output rgmii_txctl,
	output rgmii_txc,
	input[3:0] rgmii_rxd,
	input rgmii_rxctl,
	input rgmii_rxc
  
    );

wire reset_n;
wire   [ 7:0]   gmii_txd;
wire            gmii_tx_en;
wire            gmii_tx_er;
wire            gmii_tx_clk;
wire            gmii_crs;
wire            gmii_col;
wire   [ 7:0]   gmii_rxd;
wire            gmii_rx_dv;
wire            gmii_rx_er;
wire            gmii_rx_clk;
wire  [ 1:0]    speed_selection; // 1x gigabit, 01 100Mbps, 00 10mbps
wire            duplex_mode;     // 1 full, 0 half

assign speed_selection = 2'b10;
assign duplex_mode = 1'b1;
assign e_reset = reset_n;


util_gmii_to_rgmii util_gmii_to_rgmii_m0(
	.reset(1'b0),
	
	.rgmii_td(rgmii_txd),
	.rgmii_tx_ctl(rgmii_txctl),
	.rgmii_txc(rgmii_txc),
	.rgmii_rd(rgmii_rxd),
	.rgmii_rx_ctl(rgmii_rxctl),
	.rgmii_rxc(rgmii_rxc),
	
	.gmii_txd(gmii_txd),
	.gmii_tx_en(gmii_tx_en),
	.gmii_tx_er(gmii_tx_er),
	.gmii_tx_clk(gmii_tx_clk),
	.gmii_crs(gmii_crs),
	.gmii_col(gmii_col),
	.gmii_rxd(gmii_rxd),
	.gmii_rx_dv(gmii_rx_dv),
	.gmii_rx_er(gmii_rx_er),
	.gmii_rx_clk(gmii_rx_clk),
	.speed_selection(speed_selection),
	.duplex_mode(duplex_mode));
//////////////////////////////////////////////////////////

wire [31:0] ram_wr_data;
wire [31:0] ram_rd_data;
wire [8:0] ram_wr_addr;
wire [8:0] ram_rd_addr;
reg ram_wren_i;
wire [31:0] datain_reg;

wire [3:0] tx_state;
wire [3:0] rx_state;
wire [15:0] rx_total_length;    
wire [15:0] tx_total_length;    
wire [15:0] rx_data_length;     
wire [15:0] tx_data_length;     
wire data_receive;
reg ram_wr_finish;
reg [31:0] udp_data [4:0];                        
reg [8:0] ram_addr_i;
reg [31:0] ram_data_i;
reg [4:0] i;
wire data_o_valid;
wire wea;
wire [8:0] addra;
wire [31:0] dina;
assign wea = ram_wr_finish ? data_o_valid : ram_wren_i;
assign addra = ram_wr_finish ? ram_wr_addr : ram_addr_i;
assign dina = ram_wr_finish ? ram_wr_data : ram_data_i;


assign tx_data_length = data_receive ? rx_data_length : 16'd28;
assign tx_total_length = data_receive ? rx_total_length : 16'd48;


reset reset_m0(
	.clk(sys_clk),
	.key1(key1),
	.rst_n(reset_n)
);

//MDIO¼Ä´æÆ÷ÅäÖÃ
wire [15:0] phy_reg;
wire phy_init;           //PHY link up³õÊ¼»¯Íê³É
phy_reg_config phy_reg_config_inst( 
 	 .clock_50m(sys_clk),
 	 .reset_n(reset_n),
	 .phy_mdc(e_mdc),
	 .phy_mdio(e_mdio),
	 .phy_reg(phy_reg),
	 .phy_rst_n(),
	 .phy_init(phy_init)
					);	
//MDIO¼Ä´æÆ÷ÅäÖÃ
udp u1(
	.reset_n(reset_n),
	.g_clk(gmii_tx_clk),
	
	.e_rxc(gmii_rx_clk),
	.e_rxd(gmii_rxd),
	.e_rxdv(gmii_rx_dv),
	.e_txen(gmii_tx_en),
	.e_txd(gmii_txd),
	.e_txer(gmii_tx_er),		
	
	.data_o_valid(data_o_valid),          
	.ram_wr_data(ram_wr_data),            
	.rx_total_length(rx_total_length),    
	.rx_state(rx_state),                  
	.rx_data_length(rx_data_length),      
	.ram_wr_addr(ram_wr_addr),            
	.data_receive(data_receive),        
	.ram_rd_data(ram_rd_data),            
	.tx_state(tx_state),                  
	
	.tx_data_length(tx_data_length),      
	.tx_total_length(tx_total_length),    
	.ram_rd_addr(ram_rd_addr)             

	);

ram ram_inst (
	.clka(gmii_rx_clk),                                  // input clka
	.wea(wea),                                     // input [0 : 0] wea
	.addra(addra),                                 // input [8 : 0] addra
	.dina(dina),                                   // input [31 : 0] dina
	
	.clkb(gmii_tx_clk),                                  // input clkb
	.addrb(ram_rd_addr),                           // input [8 : 0] addrb
	.doutb(ram_rd_data)                            // output [31 : 0] doutb
);

/********************************************/
//´æ´¢´ı·¢ËÍµÄ×Ö·û
/********************************************/
always @(*)
begin     //¶¨Òå·¢ËÍµÄ×Ö·û
	 udp_data[0]<={"H","E","L","L"};   //´æ´¢×Ö·ûHELL 
	 udp_data[1]<={"O"," ","A","L"};   //´æ´¢×Ö·ûO¿Õ¸ñAL 
    udp_data[2]<={"I","N","X"," "};   //´æ´¢×Ö·ûINX¿Õ¸ñ
	 udp_data[3]<={"A","X","7","1"};   //´æ´¢×Ö·ûAV60	 
	 udp_data[4]<={"0","3","\r","\n"};   //´æ´¢×Ö·û45»»ĞĞ·û»Ø³µ·û                            

end 

always@(posedge gmii_rx_clk)
begin	
  if(reset_n == 1'b0) begin
     ram_wr_finish <= 1'b0;
	  ram_addr_i <= 0;
	  ram_data_i <= 0;
	  i <= 0;
  end
  else begin
     if(i == 5) begin
        ram_wr_finish <= 1'b1;
        ram_wren_i<=1'b0;		  
     end
     else begin
        ram_wren_i <= 1'b1;
		  ram_addr_i <= ram_addr_i+1'b1;
		  ram_data_i <= udp_data[i];
		  i <= i + 1'b1;
	  end
  end 
end 	


endmodule
