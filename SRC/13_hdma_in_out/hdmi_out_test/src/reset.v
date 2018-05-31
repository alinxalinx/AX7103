/*�?单上电复位模�当计数器�xffff时复位信号为1
*/
module reset(
	input clk,
	output rst_n
);
reg[31:0] cnt = 0;
reg rst_n_reg;
assign rst_n = rst_n_reg;
always@(posedge clk)
	if(cnt != 150_000_000)
		cnt <= cnt + 1;
	else
		cnt <= cnt;
always@(posedge clk)
	rst_n_reg <= (cnt == 150_000_000);
endmodule 