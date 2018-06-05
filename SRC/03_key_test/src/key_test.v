//===========================================================================
// Module name: key_test.v
// 描述: 检测开发板上的2个按键KEY1~KEY2, 当检测到按键按下时,相应的LED灯翻转
//===========================================================================
`timescale 1ns / 1ps
module key_test  (
                     input         sys_clk_p,                     // 开发板上差分输入时钟P: 200Mhz
                     input         sys_clk_n,                    // 开发板上差分输入时钟N: 200Mhz
					 input		    rst_n,                        // 开发板（核心板）上输入复位按键
					 input	[1:0]	key_in,                       // 底板上输入按键信号(KEY1~KEY2)
					 output	[1:0]	led_out                       // 输出LED灯,用于控制开发板上四个LED(LED1~LED2)
						);

	
//寄存器定义
reg [23:0] count;
reg [1:0] key_scan; //按键扫描值KEY

//差分时钟转换成单端时钟
wire sys_clk_ibufg;
 IBUFGDS #
       (
        .DIFF_TERM    ("TRUE"),
        .IBUF_LOW_PWR ("FALSE")
        )
       u_ibufg_sys_clk
         (
          .I  (sys_clk_p),
          .IB (sys_clk_n),
          .O  (sys_clk_ibufg)
          );

//===========================================================================
// 采样按键值，20ms扫描一次,采样频率小于按键毛刺频率，相当于滤除掉了高频毛刺信号。
//===========================================================================
always @(posedge sys_clk_ibufg or negedge rst_n)     //检测时钟的上升沿和复位的下降沿
begin
   if(!rst_n)                //复位信号低有效
      count <= 24'd0;        //计数器清0
   else
      begin
         if(count ==24'd3_999_999)   //20ms扫描一次按键,20ms计数(200M/50-1=3_999_999)
            begin
               count <= 24'b0;     //计数器计到20ms，计数器清零
               key_scan <= key_in; //采样按键输入电平
            end
         else
            count <= count + 24'b1; //计数器加1
     end
end
//===========================================================================
// 按键信号锁存一个时钟节拍
//===========================================================================
reg [1:0] key_scan_r;
always @(posedge sys_clk_ibufg)
    key_scan_r <= key_scan;       
    
wire [1:0] flag_key = key_scan_r[1:0] & (~key_scan[1:0]);  //当检测到按键有下降沿变化时，代表该按键被按下，按键有效 

//===========================================================================
// LED灯控制,按键按下时,相关的LED输出翻转
//===========================================================================
reg [1:0] temp_led;
always @ (posedge sys_clk_ibufg or negedge rst_n)      //检测时钟的上升沿和复位的下降沿
begin
    if (!rst_n)                 //复位信号低有效
         temp_led <= 2'b11;   //LED灯控制信号输出为低, LED灯全灭
    else
         begin            
             if ( flag_key[0] ) temp_led[0] <= ~temp_led[0];   //按键KEY1值变化时，LED1将做亮灭翻转
             if ( flag_key[1] ) temp_led[1] <= ~temp_led[1];   //按键KEY2值变化时，LED2将做亮灭翻转

         end
end
 
 assign led_out[0] = temp_led[0];
 assign led_out[1] = temp_led[1];

            
endmodule
