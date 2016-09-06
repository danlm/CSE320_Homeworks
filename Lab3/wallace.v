module HALF_ADDER(
	input	A,
	input B,
	output Sum,
	output Cout
    );
	
	assign Sum = A ^ B;
	assign Cout = A & B;

endmodule

/////////////////////////////////////////////////////////////////////

module FULL_ADDER(
	input	A,
	input B,
	input Cin,
	output Sum,
	output Cout
    );

	wire P, G;
	
	assign P = (A ^ B);
	assign G = A & B;
	
	assign Sum = P ^ Cin;
	assign Cout = G | (Cin & P);

endmodule

/////////////////////////////////////////////////////////////////////

module WM_4x4
			#(parameter WORD_WIDTH = 4)
			(input wire [WORD_WIDTH-1:0] a,
			 input wire [WORD_WIDTH-1:0] b,
			 output [WORD_WIDTH*2-1:0] out);

	wire [WORD_WIDTH-1:0] p [WORD_WIDTH-1:0];
	wire [29:0] c;
	reg overflow;
	
	generate
		genvar x;
		genvar y;
		
		for(x = 0; x < WORD_WIDTH; x = x + 1) begin
			for(y = 0; y < WORD_WIDTH; y = y + 1) begin: Partials
				assign p[x][y] = a[y] & b[x];
			end
		end
	endgenerate
		
	//Reduction Layer 1
	assign c[27] = p[0][0];
	HALF_ADDER ha1(p[0][1], p[1][0], c[0], c[1]);
	FULL_ADDER fa1(p[0][2], p[1][1], p[2][0], c[2], c[3]);
	FULL_ADDER fa2(p[0][3], p[1][2], p[2][1], c[4], c[5]);
	FULL_ADDER fa3(p[1][3], p[2][2], p[3][1], c[6], c[7]);
	HALF_ADDER ha2(p[2][3], p[3][2], c[8], c[9]);
	
	//Reduction Layer 2
	HALF_ADDER ha3(c[1], c[2], c[10], c[11]);
	FULL_ADDER fa4(c[3], p[3][0], c[4], c[12], c[13]);
	HALF_ADDER ha4(c[5], c[6], c[14], c[15]);
	HALF_ADDER ha5(c[7], c[8], c[16], c[17]);
	HALF_ADDER ha6(c[9], p[3][3], c[18], c[28]);
	
	//Addition Layer
	HALF_ADDER ha7(c[11], c[12], c[19], c[20]);
	FULL_ADDER fa5(c[20], c[13], c[14], c[21], c[22]);
	FULL_ADDER fa6(c[22], c[15], c[16], c[23], c[24]);
	FULL_ADDER fa7(c[24], c[17], c[18], c[25], c[26]);
	HALF_ADDER ha8(c[26], c[28], c[29], overflow);
	
	assign out = {c[29], c[25], c[23], c[21], c[19], c[10], c[0], c[27]};
endmodule
