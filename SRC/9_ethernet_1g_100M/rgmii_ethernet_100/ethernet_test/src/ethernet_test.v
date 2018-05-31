`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    100M ethernet port  
//////////////////////////////////////////////////////////////////////////////////
module ethernet_test(
					input       key1,                           
                    input       sys_clk,
					output      e_reset , 					
            
				//signal connect to PHY//
                    output       e_mdc,                      //MDIO的时钟信号，用于读写PHY的寄存器
                    inout        e_mdio,                     //MDIO的数据信号，用于读写PHY的寄存器  
                    				
					input	     rgmii_rxc, 
					input        rgmii_rxctl,				           
					input  [3:0] rgmii_rxd, 
   
               
					output        rgmii_txc,  
					output        rgmii_txctl,	
					output [3:0]  rgmii_txd  	 
	  
    );

wire [31:0] ram_wr_data;
wire [31:0] ram_rd_data;
wire [8:0] ram_wr_addr;
wire [8:0] ram_rd_addr;

wire [15:0] tx_data_counter;


wire [31:0] datain_reg;
         
wire [3:0] tx_state;
wire [3:0] rx_state;
wire [15:0] rx_total_length;          //rx 的IP包的长度
wire [15:0] tx_total_length;          //tx 的IP包的长度
wire [15:0] rx_data_length;           //rx 的UDP的数据包长度
wire [15:0] tx_data_length;           //rx 的UDP的数据包长度

wire data_receive;
reg ram_wr_finish;

reg [31:0] udp_data [4:0];                        //存储发送字符
reg ram_wren_i;
reg [8:0] ram_addr_i;
reg [31:0] ram_data_i;
reg [4:0] i;

wire data_o_valid;
wire wea;
wire [8:0] addra;
wire [31:0] dina;

assign e_reset = 1'b1; 

assign wea=ram_wr_finish?data_o_valid:ram_wren_i;
assign addra=ram_wr_finish?ram_wr_addr:ram_addr_i;
assign dina=ram_wr_finish?ram_wr_data:ram_data_i;


assign tx_data_length=data_receive?rx_data_length:16'd28;
assign tx_total_length=data_receive?rx_total_length:16'd48;
       
////////PLL产生发送时钟////////////////    
wire     locked; 
wire tx_clk;   
pll pll_inst
(
     .clk_in1         (sys_clk),
     .reset           (~reset_n),
     .locked          (locked),
                      
     .clk_out1        (rgmii_txc),          //25Mhz    
     .clk_out2        (tx_clk)          //25Mhz    
          
 );
          
////////复位/////////////////          
reset reset_m0(
      .clk    (sys_clk),
      .key1   (key1),
      .rst_n  (reset_n)
);
          
////////MDIO寄存器配置///////////////// 
wire [15:0] phy_reg;
wire phy_init;           //PHY link up初始化完成
phy_reg_config phy_reg_config_inst( 
      .clock_50m  (sys_clk),
      .reset_n    (reset_n),
      .phy_mdc   (e_mdc),
      .phy_mdio  (e_mdio),
      .phy_reg   (phy_reg),
      .phy_rst_n (),
      .phy_init  (phy_init)
);    
                              
////////udp发送和接收程序/////////////////// 
udp udp_inst(
	.reset_n          (reset_n),
	.e_rxc            (rgmii_rxc),
	.e_rxd            (rgmii_rxd),
    .e_rxdv           (rgmii_rxctl),
	.data_o_valid     (data_o_valid),                    //数据接收有效信号,写入RAM/
	.ram_wr_data      (ram_wr_data),                      //接收到的32bit数据写入RAM/	
	.rx_total_length  (rx_total_length),              //接收IP包的总长度/
	.mydata_num       (mydata_num),                        //for debug
	.rx_state         (rx_state),                            //for debug
	.rx_data_length   (rx_data_length),                //接收IP包的数据长度/	
	.ram_wr_addr      (ram_wr_addr),
	.data_receive     (data_receive),

	.e_txc           (tx_clk),	
	.e_txen          (rgmii_txctl),
	.e_txd           (rgmii_txd),
	.e_txer          (),	
	.ram_rd_data     (ram_rd_data),                      //RAM读出的32bit数据/
	.tx_state        (tx_state),                            //for debug
	.tx_data_length  (tx_data_length),                //发送IP包的数据长度/	
	.tx_total_length (tx_total_length),              //接发送IP包的总长度/
	.ram_rd_addr     (ram_rd_addr),
	.tx_data_counter (tx_data_counter)	
	

	);

//////////ram用于存储以太网接收到的数据或测试数据///////////////////
ram ram_inst (
  .clka(rgmii_rxc),           // input clka
  .wea(wea),     // input [0 : 0] wea
  .addra(addra),    // input [8 : 0] addra
  .dina(dina),     // input [31 : 0] dina
  
  .clkb(tx_clk),           // input clkb
  .addrb(ram_rd_addr),    // input [8 : 0] addrb
  .doutb(ram_rd_data)     // output [31 : 0] doutb
);

/********************************************/
//存储待发送的字符
/********************************************/
always @(*)
begin     //定义发送的字符
	 udp_data[0]<={8'd72,8'd69,8'd76,8'd76};   //存储字符HELL 
	 udp_data[1]<={8'd79,8'd32,8'd65,8'd76};   //存储字符O空格AL 
     udp_data[2]<={8'd73,8'd78,8'd88,8'd32};   //存储字符INX空格
	 udp_data[3]<={8'd65,8'd88,8'd55,8'd49};   //存储字符AX71 	 
	 udp_data[4]<={8'd48,8'd49,8'd10,8'd13};   //存储字符01换行符回车符                            

end 


//////////写入默认发送的数据//////////////////
always@(posedge rgmii_rxc)
begin	
  if(reset_n==1'b0) begin
     ram_wr_finish<=1'b0;
	  ram_addr_i<=0;
	  ram_data_i<=0;
	  i<=0;
  end
  else begin
     if(i==5) begin
        ram_wr_finish<=1'b1;
        ram_wren_i<=1'b0;		  
     end
     else begin
        ram_wren_i<=1'b1;
		  ram_addr_i<=ram_addr_i+1'b1;
		  ram_data_i<=udp_data[i];
		  i<=i+1'b1;
	  end
  end 
end  


endmodule
