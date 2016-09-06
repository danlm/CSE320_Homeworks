// File name: full_adder_dat.v
// Description: 1-bit full adder

`timescale 1ns / 1ns

module full_adder_dat (input wire a, b, cin,
		output wire sum, cout);

	assign sum = a ^ b ^ cin;
	assign cout = (a&b) | cin & (a^b);

endmodule
