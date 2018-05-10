module pe ( 
	Clk, Reset_n,
	in0, in1, in2, in3,
	out0, out1, out2, out3,
	tf,
	bypass_n
);

parameter WIDTH = 16;
parameter SHIFT = 8;

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

input 		[2 * WIDTH - 1 : 0]	tf;
input 					bypass_n;

reg		[WIDTH - 1 : 0]		tf0_r;
reg		[WIDTH - 1 : 0]		tf0_i;
reg		[WIDTH - 1 : 0]		tf1_r;
reg		[WIDTH - 1 : 0]		tf1_i;
reg		[WIDTH - 1 : 0]		mid0[0 : 3];
reg		[WIDTH - 1 : 0]		mid1[0 : 3];
reg		[WIDTH - 1 : 0]		mid2[0 : 3];
reg		[2 * WIDTH - 1 : 0]		mid11[0 : 1];
reg		[2 * WIDTH - 1 : 0]		mid12[0 : 1];



always @ (posedge Clk)
	begin
	if (Reset_n == 1'b0)
		begin
		mid0[0] <= 0;
		mid0[1] <= 0;
		mid0[2] <= 0;
		mid0[3] <= 0;
		tf0_r	<= 0;
		tf0_i	<= 0;
		end
	else 
		begin
		mid0[0] <= in0 + in1;
		mid0[1] <= in0 - in1;
		mid0[2] <= in2 + in3;
		mid0[3] <= in2 - in3;	
		tf0_r <= tf[2 * WIDTH - 1 : WIDTH];
		tf0_i <= tf[WIDTH - 1 : 0];
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
		tf1_r <= 0;
		tf1_i <= 0;
		end
	else 
		begin
		mid1[0] <= mid0[0];
		mid1[1] <= mid0[2];
		mid1[2] <= mid0[1];
		mid1[3] <= mid0[3];
		mid11[0] <= mid0[1] * tf0_r ;
		mid11[1] <= -(mid0[1] * tf0_i) ;
		tf1_r <= tf_0r;
		tf1_i <= tf_1i;
		end
	end
	
always @ (posedge Clk)
	begin
	if (Reset_n == 1'b0)
		begin
		mid2[0] <= 0;
		mid2[1] <= 0;
		mid2[2] <= 0;
		mid2[3] <= 0;
		mid12[0] <= 0;
		mid12[1] <= 0;
		end
	else 
		begin
		mid2[0] <= mid0[0];
		mid2[1] <= mid0[2];
		mid2[2] <= mid0[1];
		mid2[3] <= mid0[3];
		mid12[0] <= mid11[0] - mid1[3] * tf1_i;
		mid12[1] <= mid11[1] - mid1[3] * tf1_r;		
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
		out0 <= mid2[0];
		out1 <= mid2[1];
		out2 <= (bypass_n) ? mid12[0][SHIFT + WIDTH - 1 : SHIFT] : mid2[2];
		out3 <= (bypass_n) ? mid12[1][SHIFT + WIDTH - 1 : SHIFT] : mid2[3];
		end
	end


endmodule
