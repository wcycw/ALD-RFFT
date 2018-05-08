module PE ( 
	Clk, Reset_n,
	in0, in1, in2, in3,
	out0, out1, out2, out3,
	tf,
	bypass_n
);

parameter WIDTH = 32;
parameter SHIFT = 16;

input					Clk;
input 					Reset_n;

input 		[WIDTH - 1 : 0]		in0;
input 		[WIDTH - 1 : 0]		in1;
input 		[WIDTH - 1 : 0]		in2;
input 		[WIDTH - 1 : 0]		in3;

output reg 	[WIDTH - 1 : 0]		out0;
output reg 	[WIDTH - 1 : 0]		out1;
output reg 	[WIDTH - 1 : 0]		out2;
output reg 	[WIDTH - 1 : 0]		out3;

input 		[WIDTH - 1 : 0]		tf;
input 					bypass_n;


reg		[WIDTH - 1 : 0]		mid0[0 : 3];
reg		[WIDTH - 1 : 0]		mid1[0 : 3];
reg		[2* WIDTH - 1 : 0]	mid11[0 : 1];



always @ (posedge Clk)
	begin
	if (Reset_n == 1'b0)
		begin
		mid0[0] <= 0;
		mid0[1] <= 0;
		mid0[2] <= 0;
		mid0[3] <= 0;
		end
	else 
		begin
		mid0[0] <= in0 + in1;
		mid0[1] <= in0 - in1;
		mid0[2] <= in2 + in3;
		mid0[3] <= in2 - in3;
		end
	end

always @ (posedge Clk)
	begin
	if (Reset_n == 1'b0)
		begin
		mid1[0] <= 0;
		mid1[1] <= 0;
		mid1[2] <= 0;
		mid1[3] <= 0;
		mid11[0] <= 0;
		mid11[1] <= 0;
		end
	else 
		begin
		mid1[0] <= mid0[0];
		mid1[1] <= mid0[2];
		mid1[2] <= mid0[1];
		mid1[3] <= mid0[3];
		mid11[0] <= mid0[1] * tf;
		mid11[1] <= mid0[3] * tf;
		end
	end


always @ (posedge Clk)
	begin
	if (Reset_n == 1'b0)
		begin
		out0 <= 0;
		out1 <= 0;
		out2 <= 0;
		out3 <= 0;
		end
	else 
		begin
		out0 <= mid1[0];
		out1 <= mid1[1];
		out2 <= (bypass_n) ? mid11[0][SHIFT + WIDTH - 1 : SHIFT] : mid1[2];
		out3 <= (bypass_n) ? mid11[1][SHIFT + WIDTH - 1 : SHIFT] : mid1[3];
		end
	end


endmodule