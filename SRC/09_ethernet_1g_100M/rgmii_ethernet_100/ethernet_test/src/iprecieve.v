`timescale 1ns / 1ps

module iprecieve(
					 input                  clk,
					 input       [3:0]      datain,
					 input                  rxdv,

					 output reg [47:0]      board_mac,
					 output reg [47:0]      pc_mac,
					 output reg [15:0]      IP_Prtcl,
					 output reg [159:0]     IP_layer,
					 output reg [31:0]      pc_IP,
					 output reg [31:0]      board_IP,
					 output reg [63:0]      UDP_layer,
					 output reg [31:0]      data_o,
					 output reg             valid_ip_P,
					 output reg [15:0]      rx_total_length,         //UDP frame的总长度
					 output reg             data_o_valid,            //added for receive test// 					 
					 output reg [3:0]       rx_state,
					 output reg [15:0]      rx_data_length,	       //接收的UDP数据包的长度				 
  
					 output reg [8:0]       ram_wr_addr,
					 output reg             data_receive

				);
	 
reg [15:0] myIP_Prtcl;
reg [159:0] myIP_layer;
reg [63:0] myUDP_layer;
reg [31:0] mydata; 
reg [2:0] byte_counter;
reg [4:0] state_counter;
reg [95:0] mymac;
reg [15:0] data_counter;


 
parameter idle=4'd0,six_55=4'd1,spd_d5=4'd2,rx_mac=4'd3,rx_IP_Protocol=4'd4,
          rx_IP_layer=4'd5,rx_UDP_layer=4'd6,rx_data=4'd7,rx_finish=4'd8;
	 
initial
begin
	 rx_state<=idle;
	 data_receive<=1'b0;
end


//4bit->byte
reg [7:0] mybyte;
reg sig;
always @(posedge clk)
begin
	if(rxdv)	begin
			mybyte<={datain,mybyte[7:4]};
			sig<=~sig;
	end
	else begin
		   mybyte<=mybyte;
		   sig<=1'b0;
	end
end

//4bit->byte
reg [7:0] byte_data;
always @(posedge clk)
begin
	if(sig&&rxdv) begin
		byte_data<={datain,mybyte[7:4]};
	end
	else if(!rxdv)
	    byte_data<=8'd0;
end

//generate byte rxdv signal
reg byte_sig_t,byte_sig;
reg byte_rxdv_t,byte_rxdv;

always @(posedge clk)
begin
	byte_sig_t<=sig;
	byte_sig<=byte_sig_t;
	
	byte_rxdv_t<= rxdv;
	byte_rxdv<=byte_rxdv_t;
	
end


always@(posedge clk)
	begin
		case(rx_state)
        idle:	begin
			     valid_ip_P<=1'b0;
			     byte_counter<=3'd0;
			     state_counter<=5'd0;	
				  data_o_valid<=1'b0; 
              data_counter<=10'd0;	
              mydata	<=0;	
              ram_wr_addr<=0;					  
				  if(byte_rxdv&&!byte_sig)  begin
					  if(byte_data==8'h55)
					     rx_state<=six_55; 
				  end
		  end		  
		  six_55:begin                       //接收6个0x55			 
				if(byte_rxdv&&!byte_sig) begin				  
		          if(byte_data!=8'h55)begin rx_state<=idle;byte_counter<=3'd0;end
		          else begin 
		               if(byte_counter<3'd5)
								byte_counter<=byte_counter+1'b1;
						   else  begin
								  byte_counter<=3'd0;
								  rx_state<=spd_d5;
							end
					end
				end
				else if(!byte_rxdv) rx_state<=idle;
		   end
			spd_d5: begin                     //接收0xd5				
				if(byte_rxdv&&!byte_sig) begin
						if(byte_data==8'hd5)
								rx_state<=rx_mac;
						else
								rx_state<=idle;
				end
				else if(!byte_rxdv) rx_state<=idle;
			end
			rx_mac: begin                    //接收目标mac address和源mac address				
				if(byte_rxdv&&!byte_sig) begin
					if(state_counter<5'd11)	begin
							mymac<={mymac[87:0],byte_data};
							state_counter<=state_counter+1'b1;
					end
					else begin
							board_mac<=mymac[87:40];
							pc_mac<={mymac[39:0],byte_data};
							state_counter<=5'd0;
							if((mymac[87:72]==16'h000a)&&(mymac[71:56]==16'h3501)&&(mymac[55:40]==16'hfec0))   //判断目标MAC Address是否为本FPGA
								   rx_state<=rx_IP_Protocol;
							else
								   rx_state<=idle;
					end
				end
				else if(!byte_rxdv) rx_state<=idle;
			end
		   rx_IP_Protocol: begin                 //接收2个字节的IP类型				
					if(byte_rxdv&&!byte_sig) begin
							if(state_counter<5'd1) begin
								   myIP_Prtcl<={myIP_Prtcl[7:0],byte_data};
								   state_counter<=state_counter+1'b1;
							end
							else begin
									IP_Prtcl<={myIP_Prtcl[7:0],byte_data};
									valid_ip_P<=1'b1;
                           state_counter<=5'd0;
									rx_state<=rx_IP_layer;
							end
						end
					else if(!byte_rxdv) rx_state<=idle;
			 end		              
		    rx_IP_layer: begin               //接收20字节的udp虚拟包头,ip address		        
				   valid_ip_P<=1'b0;
					if(byte_rxdv&&!byte_sig) begin
							if(state_counter<5'd19)	begin
									myIP_layer<={myIP_layer[151:0],byte_data};
									state_counter<=state_counter+1'b1;
							end
							else begin
									IP_layer<={myIP_layer[151:0],byte_data};									
									state_counter<=5'd0;
									rx_state<=rx_UDP_layer;
							end
					end
					else if(!byte_rxdv) rx_state<=idle;
			end           
			rx_UDP_layer: begin                      //接受8字节udp数据包头,端口号及包长	 				 
				    rx_total_length<=IP_layer[143:128];
				    pc_IP<=IP_layer[63:32];
				    board_IP<=IP_layer[31:0];
					if(byte_rxdv&&!byte_sig) begin
							if(state_counter<5'd7) begin
								myUDP_layer<={myUDP_layer[55:0],byte_data};
								state_counter<=state_counter+1'b1;
							end
							else begin
								UDP_layer<={myUDP_layer[55:0],byte_data};	
                        rx_data_length<= myUDP_layer[23:8];                //UDP数据包的长度								
								state_counter<=5'd0;
								rx_state<=rx_data;
							end
					end
					else if(!byte_rxdv) rx_state<=idle;
			 end    
			 rx_data:begin                                    //接收udp数据    
					if(byte_rxdv&&!byte_sig) begin
					   if (data_counter==rx_data_length-9) begin         //存最后的数据
						    data_counter<=0;
  					       rx_state<=rx_finish;
							 ram_wr_addr<=ram_wr_addr+1'b1;	
							 data_o_valid<=1'b1;               //写RAM 							 
						    if(byte_counter==3'd3) begin
								  data_o<={mydata[23:0],byte_data[7:0]};
								  byte_counter<=0;
							 end
						    else if(byte_counter==3'd2) begin
						        data_o<={mydata[15:0],byte_data[7:0],8'h00};       //不满32bit,补0
								  byte_counter<=0;
							 end
						    else if(byte_counter==3'd1) begin
						        data_o<={mydata[7:0],byte_data[7:0],16'h0000};     //不满32bit,补0
								  byte_counter<=0;
							 end
						    else if(byte_counter==3'd0) begin
						        data_o<={byte_data[7:0],24'h000000};              //不满32bit,补0
								  byte_counter<=0;
							 end
						end
						else begin
							 data_counter<=data_counter+1'b1;
						    if(byte_counter<3'd3)	begin
								  mydata<={mydata[23:0],byte_data[7:0]};
								  byte_counter<=byte_counter+1'b1;
					           data_o_valid<=1'b0;  
							 end
							 else begin
						        data_o<={mydata[23:0],byte_data[7:0]};
						        byte_counter<=3'd0;
								  data_o_valid<=1'b1;                        //接受4byes数据,写ram请求
                          ram_wr_addr<=ram_wr_addr+1'b1;							  
                      end	
                  end							 
               end
					else if(!byte_rxdv)
  					    rx_state<=idle;
			 end   
			 rx_finish:begin    
   			   data_o_valid<=1'b0;               //added for receive test// 
					data_receive<=1'b1;
					rx_state<=idle;  			  
			 end 
			 default:rx_state<=idle;    
		endcase
		end
endmodule