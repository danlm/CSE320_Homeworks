// File name: alu.v
// Description: 4-bit ALU that does addition, subtraction, multiplication, division, and modulus

module ALU_bhv (a, b, sel, c);

	input [3:0] a;
	input [3:0] b;
	input [2:0] sel;
	output [3:0] c;

	wire [3:0] a;
	wire [3:0] b;
	wire [2:0] sel;
	reg [3:0] c;
	
always @(a or b or sel)
  case (sel)
        0: c = a + b;
        1: c = a - b;
        2: c = a * b;
        3: c = a / b;
        4: c = a % b;
      endcase

endmodule