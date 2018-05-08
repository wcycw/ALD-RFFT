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
module bram(
	Clk, En, We, Addr_A,  DI_A,  DO_A
    );
parameter WIDTH = 32;

input 		Clk;
input 		En;
input 		We;
input 		[5 : 0]			Addr_A;

input 		[WIDTH - 1 : 0]	DI_A;
output 		[WIDTH - 1 : 0]	DO_A;


reg 		[WIDTH - 1 : 0]		ram 	 [0 : 63];
reg	 	[WIDTH - 1 : 0]	DO_A;


always @(posedge Clk) 
	begin
	if (En)
		begin
		if (We)
			ram[Addr_A] <= DI_A;
		DO_A <= ram[Addr_A];
		end 
	end
	


endmodule


