`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:38:51 12/06/2014 
// Design Name: 
// Module Name:    p_and_g_4 
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
module p_and_g_4
	#(parameter WIDTH = 4)
	(input wire [WIDTH - 1:0] A,
	input wire [WIDTH - 1:0] B,
	output wire [WIDTH - 1:0] P,
	output wire [WIDTH - 1:0] G);
	
	genvar i;
	generate for(i = 0; i < WIDTH; i = i+1) begin: p_and_g_4
			p_and_g 
				i_p_and_g_b4(
				.A(A[i]),
				.B(B[i]),
				.P(P[i]),
				.G(G[i]));
		end
	endgenerate
	
endmodule
