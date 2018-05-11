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

reg			[WIDTH - 1 : 0]		tf0_r;
reg			[WIDTH - 1 : 0]		tf0_i;
reg			[WIDTH - 1 : 0]		tf1_r;
reg			[WIDTH - 1 : 0]		tf1_i;
reg			[WIDTH - 1 : 0]		tfin_r;
reg			[WIDTH - 1 : 0]		tfin_i;
reg			[WIDTH - 1 : 0]		midin[0 : 3];
reg			[WIDTH - 1 : 0]		mid0[0 : 3];
reg			[WIDTH - 1 : 0]		mid1[0 : 3];
reg			[WIDTH - 1 : 0]		mid2[0 : 3];
reg			[WIDTH - 1 : 0]		mid3[0 : 3];
reg			[2 * WIDTH - 1 : 0]		mid11[0 : 1];
reg			[2 * WIDTH - 1 : 0]		mid12[0 : 1];
reg			[2 * WIDTH - 1 : 0]		midout[0 : 1];

// read data and transfer them into 2'c
always @ (posedge Clk)
	begin
	if (Reset_n == 1'b0)
		begin
		midin[0] <= 0;
		midin[1] <= 0;
		midin[2] <= 0;
		midin[3] <= 0;
		tfin_r	<= 0;
		tfin_i	<= 0;
		end
	else 
		begin
		midin[0] <= (in0[WIDTH - 1]==1)?(~{1'b0,in0[WIDTH - 2:0]}+ 1'b1) : in0;
		midin[1] <= (in1[WIDTH - 1]==1)?(~{1'b0,in0[WIDTH - 2:0]}+ 1'b1) : in1;
		midin[2] <= (in2[WIDTH - 1]==1)?(~{1'b0,in0[WIDTH - 2:0]}+ 1'b1) : in2;
		midin[3] <= (in3[WIDTH - 1]==1)?(~{1'b0,in0[WIDTH - 2:0]}+ 1'b1) : in3;	
		tfin_r <= tf[2 * WIDTH - 1 : WIDTH];
		tfin_i <= tf[WIDTH - 1 : 0];
		end
	end

// add and sub in 2'c
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
		mid0[0] <= midin[0] + midin[1];
		mid0[1] <= midin[0] - midin[1];
		mid0[2] <= midin[2] + midin[3];
		mid0[3] <= midin[2] - midin[3];	
		tf0_r <= tfin_r;
		tf0_i <= tfin_i;
		end
	end

// 2'c->true and prepare for multi
always @ (posedge Clk)
	begin
	if (Reset_n == 1'b0)
		begin
		mid1[0] <= 0;
		mid1[1] <= 0;
		mid1[2] <= 0;
		mid1[3] <= 0;

		tf1_r <= 0;
		tf1_i <= 0;
		end
	else 
		begin
		mid1[0]<=(mid0[0][WIDTH - 1])?{1'b1,~(mid0[0][WIDTH - 2:0]- 1'b1)} : mid0[0];
		mid1[1]<=(mid0[2][WIDTH - 1])?{1'b1,~(mid0[2][WIDTH - 2:0]- 1'b1)} : mid0[2];
		mid1[2]<=(mid0[1][WIDTH - 1])?{1'b1,~(mid0[1][WIDTH - 2:0]- 1'b1)} : mid0[1];
		mid1[3]<=(mid0[3][WIDTH - 1])?{1'b1,~(mid0[3][WIDTH - 2:0]- 1'b1)} : mid0[3];

		tf1_r <= tf0_r;
		tf1_i <= tf0_i;
		end
	end

// multiply	(true)
always @ (posedge Clk)
	begin
	if (Reset_n == 1'b0)
		begin
		mid2[0] <= 0;
		mid2[1] <= 0;
		mid2[2] <= 0;
		mid2[3] <= 0;
		mid11[0] <= 0;
		mid11[1] <= 0;
		mid12[0] <= 0;
		mid12[1] <= 0;
		end
	else 
		begin
		mid2[0] <= mid1[0];
		mid2[1] <= mid1[1];
		mid2[2] <= mid1[2];
		mid2[3] <= mid1[3];
		mid11[0] <= { mid1[2][WIDTH-1]^tf1_r[WIDTH-1] , 31'b(mid1[2][WIDTH-2:0] * tf1_r[ WIDTH-2:0])};
		mid11[1] <= { mid1[2][WIDTH-1]^tf1_i[WIDTH-1] , 31'b(mid1[2][WIDTH-2:0] * tf1_i[ WIDTH-2:0])};
		mid12[0] <= { mid1[3][WIDTH-1]^tf1_i[WIDTH-1] , 31'b(mid1[3][WIDTH-2:0] * tf1_i[ WIDTH-2:0])};
		mid12[1] <= { mid1[3][WIDTH-1]^tf1_r[WIDTH-1] , 31'b(mid1[3][WIDTH-2:0] * tf1_r[ WIDTH-2:0])};		
		end
	end

// add product (2'c) from mult 
always @ (posedge Clk)
	begin
	if (Reset_n == 1'b0)
		begin
		mid3[0] <= 0;
		mid3[1] <= 0;
		mid3[2] <= 0;
		mid3[3] <= 0;
		midout[0] <= 0;
		midout[1] <= 0;
		end
	else 
		begin
		mid3[0]<= mid2[0];
		mid3[1]<= mid2[1];
		mid3[2]<= mid2[2];
		mid3[3]<= mid2[3];
		midout[0] <= ((mid11[0][2*WIDTH - 1])?(~{1'b0,mid11[0][2*WIDTH - 2:0]}+ 1'b1): mid11[0]) - ((mid12[0][2*WIDTH - 1])?(~{1'b0,mid12[0][2*WIDTH - 2:0]}+ 1'b1): mid12[0]);
		midout[1] <= 0 - ((mid11[1][2*WIDTH - 1])?(~{1'b0,mid11[1][2*WIDTH - 2:0]}+ 1'b1): mid11[1]) - ((mid12[1][2*WIDTH - 1])?(~{1'b0,mid12[1][2*WIDTH - 2:0]}+ 1'b1): mid12[1]);
		end
	end

//output
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
		out0 <= mid3[0];
		out1 <= mid3[1];
		out2 <= (bypass_n) ? ({midout[0][2*WIDTH-1], ((midout[0][2*WIDTH-1])?{1'b1,~(midout[0][2*WIDTH - 2:0]- 1'b1)} : midout[0])[SHIFT + WIDTH - 2 : SHIFT]}): mid3[2];
		out3 <= (bypass_n) ? ({midout[1][2*WIDTH-1], ((midout[0][2*WIDTH-1])?{1'b1,~(midout[0][2*WIDTH - 2:0]- 1'b1)} : midout[0])[SHIFT + WIDTH - 2 : SHIFT]}): mid3[3];
		end
	end


endmodule
