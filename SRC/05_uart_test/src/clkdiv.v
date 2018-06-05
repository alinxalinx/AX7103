`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    clkdiv
// 产生一个波特率9600的16倍频的时钟，9600*16= 153600
// 相当于200MHz的1302分频，200000000/153600=1302
//////////////////////////////////////////////////////////////////////////////////
module clkdiv(clk200, clkout);
input clk200;              //系统时钟
output clkout;          //采样时钟输出
reg clkout;
reg [15:0] cnt;

//分频进程,对50Mhz的时钟1302分频
always @(posedge clk200)   
begin
  if(cnt == 16'd560)
  begin
    clkout <= 1'b1;
    cnt <= cnt + 16'd1;
  end
  else if(cnt == 16'd1301)
  begin
    clkout <= 1'b0;
    cnt <= 16'd0;
  end
  else
  begin
    cnt <= cnt + 16'd1;
  end
end
endmodule
