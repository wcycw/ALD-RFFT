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

input 		[2 * WIDTH - 1 : 0]	DI_A;
output 		[2 * WIDTH - 1 : 0]	DO_A;
reg	 	[2 * WIDTH - 1 : 0]	DO_A;

input 		[5 : 0]		Addr_B;

input 		[2 * WIDTH - 1 : 0]	DI_B;
output 		[2 * WIDTH - 1 : 0]	DO_B;
reg	 	[2 * WIDTH - 1 : 0]	DO_B;

reg 		[2 * WIDTH - 1 : 0]	ram 	 [0 : 63];


always @(posedge Clk) 
	begin
	if (En)
		begin
		if (We_A)
			ram[Addr_A] <= DI_A;
		DO_A <= ram[Addr_A];
		end 
	end
	begin
	if (En)
		begin
		if (We_B)
			ram[Addr_B] <= DI_B;
		DO_B <= ram[Addr_B];
		end 
	end


endmodule


