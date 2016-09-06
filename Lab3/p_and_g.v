`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:35:30 12/06/2014 
// Design Name: 
// Module Name:    p_and_g 
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
module p_and_g(
    input wire A,
    input wire B,
    output reg P,
    output reg G
    );

	always@*
		P = A ^ B;
	
	always@*
		G = A & B;

endmodule
