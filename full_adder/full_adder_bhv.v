// File name: full_adder_bhv.v
// Description: 1-bit full adder

`timescale 1ns / 1ns

module full_adder_bhv (input wire a, b, cin,
		output reg sum, cout);

always @(a or b or cin)
  {cout, sum} = a + b + cin;

endmodule
