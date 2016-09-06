`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:53:19 12/06/2014 
// Design Name: 
// Module Name:    cp 
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
module cp(
	input wire P,
	input wire G,
	input wire Cin,
	output reg COut,
	output reg Sum
    );
	 
	always@*
		COut = G | (P & Cin);
	
	always@*
		Sum = P ^ Cin;

endmodule
