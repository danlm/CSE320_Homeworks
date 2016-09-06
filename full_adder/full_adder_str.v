// File name: full_adder_str.v
// Description: 1-bit full adder

`timescale 1ns / 1ns

primitive xor3(f,a,b,c);
output f;
input a,b,c;
table
// a    b    c     f
    0    0    0  : 0;
    0	 0    1  : 1;
    0	 1    0  : 1;
    0	 1    1  : 0;
    1	 0    0  : 1;
    1	 0    1  : 0;
    1	 1    0  : 0;
    1	 1    1  : 1;
 endtable
endprimitive


module full_adder_str (input wire a, b, cin,
		output wire sum, cout);
	
	// Use the UDP for xor to calculate sum
	xor3 x1 (sum,a,b,cin);
	
	// Use built-in primitives for carry-out
	and (c1, a, b);
	xor(c2, a, b);
	and (c3, cin, c2);
	or (cout, c1, c3);

endmodule