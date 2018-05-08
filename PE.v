module pe ( 
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

input 		[2 * WIDTH - 1 : 0]	in0;
input 		[2 * WIDTH - 1 : 0]	in1;
input 		[2 * WIDTH - 1 : 0]	in2;
input 		[2 * WIDTH - 1 : 0]	in3;

output reg 	[2 * WIDTH - 1 : 0]	out0;
output reg 	[2 * WIDTH - 1 : 0]	out1;
output reg 	[2 * WIDTH - 1 : 0]	out2;
output reg 	[2 * WIDTH - 1 : 0]	out3;

input 		[2 * WIDTH - 1 : 0]	tf;
input 					bypass_n;

reg		[WIDTH - 1 : 0]		tf0
reg		[WIDTH - 1 : 0]		mid0_r[0 : 3];
reg		[WIDTH - 1 : 0]		mid0_i[0 : 3];
reg		[WIDTH - 1 : 0]		mid1[0 : 3];
reg		[WIDTH - 1 : 0]		mid11_r[0 : 1];
reg		[WIDTH - 1 : 0]		mid11_i[0 : 1];



always @ (posedge Clk)
	begin
	if (Reset_n == 1'b0)
		begin
		mid0_r[0] <= 0;
		mid0_r[1] <= 0;
		mid0_r[2] <= 0;
		mid0_r[3] <= 0;
		mid0_i[0] <= 0;
		mid0_i[1] <= 0;
		mid0_i[2] <= 0;
		mid0_i[3] <= 0;
		tf0	<= 0;
		end
	else 
		begin
		mid0_r[0] <= in0[2 * WIDTH - 1 : WIDTH] + in1[2 * WIDTH - 1 : WIDTH];
		mid0_r[1] <= in0[2 * WIDTH - 1 : WIDTH] - in1[2 * WIDTH - 1 : WIDTH];
		mid0_r[2] <= in2[2 * WIDTH - 1 : WIDTH] + in3[2 * WIDTH - 1 : WIDTH];
		mid0_r[3] <= in2[2 * WIDTH - 1 : WIDTH] - in3[2 * WIDTH - 1 : WIDTH];
		mid0_i[0] <= in0[WIDTH - 1 : 0] + in1[WIDTH - 1 : 0];
		mid0_i[1] <= in0[WIDTH - 1 : 0] - in1[WIDTH - 1 : 0];
		mid0_i[2] <= in2[WIDTH - 1 : 0] + in3[WIDTH - 1 : 0];
		mid0_i[3] <= in2[WIDTH - 1 : 0] - in3[WIDTH - 1 : 0];
		tf0_r <= tf[2 * WIDTH - 1 : WIDTH];
		tr0_i <= tf[WIDTH - 1 : 0];
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
		mid1[0] <= {mid0_r[0], mid0_i[0]};
		mid1[1] <= {mid0_r[2], mid0_i[2]};
		mid1[2] <= {mid0_r[1], mid0_i[1]};
		mid1[3] <= {mid0_r[3], mid0_i[3]};
		mid11_r[0] <= mid0_r[1] * tf0_r - mid0_i[1] * tf0_i;
		mid11_i[0] <= mid0_r[1] * tf0_i + mid0_i[1] * tf0_r;
		mid11_r[1] <= mid0_r[3] * tf0_r - mid0_i[3] * tf0_i;
		mid11_i[1] <= mid0_r[3] * tf0_i + mid0_i[3] * tf0_r;
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
		out2 <= (bypass_n) ? {mid11[0]_r[SHIFT + WIDTH - 1 : SHIFT], mid11[0]_i[SHIFT + WIDTH - 1 : SHIFT]} : mid1[2];
		out3 <= (bypass_n) ? {mid11[1]_r[SHIFT + WIDTH - 1 : SHIFT], mid11[1]_i[SHIFT + WIDTH - 1 : SHIFT]} : mid1[3];
		end
	end


endmodule