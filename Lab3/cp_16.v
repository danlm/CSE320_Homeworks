`timescale 1ns / 1ps

module cp_16
	#(parameter WIDTH = 16)
	(input [WIDTH - 1:0] P,
    input [WIDTH - 1:0] G,
    input Cin,
    output Cout,
    output [WIDTH - 1:0] Sum
    );
	 
	wire [WIDTH:0] carry;
	assign carry[0] = Cin;
	
	genvar i;
	generate for(i = 0; i < WIDTH; i = i+1) begin: cp_16
			cp 
				i_cp_b16(
				.P(P[i]),
				.G(G[i]),
				.Cin(carry[i]),
				.COut(carry[i+1]),
				.Sum(Sum[i]));
		end
	endgenerate
	
	assign Cout = carry[WIDTH];


endmodule