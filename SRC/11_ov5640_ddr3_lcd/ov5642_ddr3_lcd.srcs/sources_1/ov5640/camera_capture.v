`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    camera_capture 
//////////////////////////////////////////////////////////////////////////////////
module camera_capture(
	input rst_n,	
	input init_done,
	input camera_pclk,
    input camera_href,
	input camera_vsync,
	input [7:0] camera_data,	
	output reg ddr_wren,                             //ddr camera写入信号, 高写
	output reg [255:0] ddr_data_camera               //ddr camera写入数据

	
);

reg [10:0] camera_h_count;            
reg [9:0] camera_v_count;       

reg [255:0] camera_data_reg;
reg [9:0] counter;

reg camera_vsync_buf1;
reg camera_vsync_buf2;

reg cmos_wren;



//产生camera行计数  
always @(posedge camera_pclk)
begin
	 if (~rst_n) 
       camera_h_count<=1;
	 else if((camera_href==1'b1) & (camera_vsync==1'b0))  
       camera_h_count<=camera_h_count+1'b1;	  
	 else 
	 	 camera_h_count<=1;
 
end

//产生camera列计数
always @(posedge camera_pclk)
begin
	 if (~rst_n | camera_vsync) 
       camera_v_count<=0;
	 else if(camera_h_count==1280)   
       camera_v_count<=camera_v_count+1'b1;	  
	 else 
	 	 camera_v_count<=camera_v_count;
end
	
//产生camera数据存储到DDR中的请求信号,转换成256bit
always @(posedge camera_pclk)
begin
	 if (~rst_n) begin 
			camera_data_reg<=0;
			cmos_wren<=1'b0;
			counter<=0;
	 end	
	 else if((camera_href==1'b1) & (camera_vsync==1'b0)) begin   //cmos数据有效
		   if(counter<31) begin                              //读取前31个camera数据	  
				 camera_data_reg<={camera_data_reg[247:0],camera_data};
				 counter<=counter+1'b1;
				 ddr_data_camera<=ddr_data_camera;	
				 cmos_wren<=1'b0;
			end
			else begin                                       //读取第32个camera数据		  
			    ddr_data_camera<={camera_data_reg[247:0],camera_data};
				 camera_data_reg<=0;		
				 counter<=0; 
			    cmos_wren<=1'b1;                              //接收到32个bytes数据,产生ddr写信号				 
			end
	  end
	  else begin
				camera_data_reg<=0;
				ddr_data_camera<=0;
				cmos_wren<=1'b0;
				counter<=0;
	  end
end

always @(negedge camera_pclk)
begin
  ddr_wren<=cmos_wren;
end  
		
endmodule

