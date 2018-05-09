`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:37:05 03/10/2017 
// Design Name: 
// Module Name:    bram_dual 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module bram_duel(
	Clk, En, We_A, Addr_A,  DI_A,  DO_A, We_B, Addr_B,  DI_B,  DO_B
    );
parameter WIDTH = 32;

input 		Clk;
input 		En;
input 		We_A;
input		We_B;
input 		[5 : 0]		Addr_A;

input 		[WIDTH - 1 : 0]	DI_A;
output 		[WIDTH - 1 : 0]	DO_A;
reg	 	[WIDTH - 1 : 0]	DO_A;

input 		[5 : 0]		Addr_B;

input 		[WIDTH - 1 : 0]	DI_B;
output 		[WIDTH - 1 : 0]	DO_B;
reg	 	[WIDTH - 1 : 0]	DO_B;

reg 		[WIDTH - 1 : 0]	ram 	 [0 : 63];

initial begin
ram[0] = 32'd5054899;
ram[1] = 32'd7694708;
ram[2] = 32'd2991237;
ram[3] = 32'd662128;
ram[4] = 32'd1207099;
ram[5] = 32'd7459969;
ram[6] = 32'd50989;
ram[7] = 32'd5105096;
ram[8] = 32'd13204488;
ram[9] = 32'd601983;
ram[10] = 32'd7654698;
ram[11] = 32'd7480215;
ram[12] = 32'd9651988;
ram[13] = 32'd8471199;
ram[14] = 32'd144834;
ram[15] = 32'd565416;
ram[16] = 32'd10124278;
ram[17] = 32'd11485147;
ram[18] = 32'd5140813;
ram[19] = 32'd13898537;
ram[20] = 32'd3324829;
ram[21] = 32'd4282848;
ram[22] = 32'd2084978;
ram[23] = 32'd11214651;
ram[24] = 32'd11256262;
ram[25] = 32'd3274823;
ram[26] = 32'd2696591;
ram[27] = 32'd2698938;
ram[28] = 32'd13488499;
ram[29] = 32'd12236807;
ram[30] = 32'd9429733;
ram[31] = 32'd7222428;
ram[32] = 32'd2300114;
ram[33] = 32'd10812684;
ram[34] = 32'd12658227;
ram[35] = 32'd2448692;
ram[36] = 32'd6201891;
ram[37] = 32'd1440990;
ram[38] = 32'd14288796;
ram[39] = 32'd7485784;
ram[40] = 32'd12019264;
ram[41] = 32'd793736;
ram[42] = 32'd2378736;
ram[43] = 32'd1344802;
ram[44] = 32'd3031694;
ram[45] = 32'd5011671;
ram[46] = 32'd12103297;
ram[47] = 32'd9589294;
ram[48] = 32'd8971991;
ram[49] = 32'd14001818;
ram[50] = 32'd2352987;
ram[51] = 32'd5224778;
ram[52] = 32'd6076794;
ram[53] = 32'd10555736;
ram[54] = 32'd12517500;
ram[55] = 32'd1076479;
ram[56] = 32'd10432444;
ram[57] = 32'd11348038;
ram[58] = 32'd4279672;
ram[59] = 32'd1911023;
ram[60] = 32'd10210071;
ram[61] = 32'd7820863;
ram[62] = 32'd3211425;
ram[63] = 32'd555016;

end

always @(posedge Clk) 
	begin
	if (En)
		begin
		if (We_A)
			ram[Addr_A] <= DI_A;
		DO_A <= ram[Addr_A];
		end
	if (En)
		begin
		if (We_B)
			ram[Addr_B] <= DI_B;
		DO_B <= ram[Addr_B];
		end 
	end


endmodule


