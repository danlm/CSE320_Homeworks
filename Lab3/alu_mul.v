module alu_mul
	#(parameter WORD_WIDTH = 32)
    (input  wire [     WORD_WIDTH  - 1:0] a,
	  input  wire [     WORD_WIDTH  - 1:0] b,
	  output wire [(2 * WORD_WIDTH) - 1:0] mul);

`define WALLACE

`ifdef BOOTH
	// Multiplier and multiplicand - add two bits to avoid corner failures
	reg [(2*WORD_WIDTH)+1:0] A, S, P, c1, c2;
	reg ready = 0;
	wire [WORD_WIDTH-1:0]comp_a;
	wire r1, r2, r3;

	// Adders ready to go using CSA_16
	alu_add comp_2(~a, 1'b1, r1, comp_a); // 2's complement of a
	alu_add #(.WORD_WIDTH((2*WORD_WIDTH)+2)) case_1 (P, A, r2, c1); // for case 1 in the algorithm: P+A
	alu_add #(.WORD_WIDTH((2*WORD_WIDTH)+2)) case_2 (P, S, r3, c2); // for case 2 in the algorithm: P+S

   initial begin
		// Initialize the first multiplicand with a, and pad to the right with 0's
		A [(2*WORD_WIDTH):(WORD_WIDTH)+1] = a;
		A[(2*WORD_WIDTH)+1] = a [WORD_WIDTH  - 1];
		A [WORD_WIDTH:0] = 0;

		// Initialize the first multiplicand with -a, and pad to the right with 0's
		S [(2*WORD_WIDTH):(WORD_WIDTH)+1] = comp_a;
		S[(2*WORD_WIDTH)+1] = comp_a[WORD_WIDTH  - 1];
		S [WORD_WIDTH:0] = 0;
		
		//Initialize the product with the value of the second multiplicand
		P [(2*WORD_WIDTH)+1:(WORD_WIDTH)+1] = 0;
		P[WORD_WIDTH:1] = b;
		P [0] = 0;
	end
	
	repeat (WORD_WIDTH) begin
		case(P[1:0])
			2'b01: begin P[(2*WORD_WIDTH)+1:0] = {c1[2*WORD_WIDTH)+1], c1[(2*WORD_WIDTH)+1:1]}; end
			2'b10: begin P[(2*WORD_WIDTH)+1:0] = {c2[2*WORD_WIDTH)+1], c2[(2*WORD_WIDTH)+1:1]}; end
			default: begin P[(2*WORD_WIDTH)+1:0] = {P[2*WORD_WIDTH)+1], P[(2*WORD_WIDTH)+1:1]}; end
		endcase
	end
	
	
	assign mul = P[(2*WORD_WIDTH):1];

`elsif WALLACE


`else
	assign mul = a * b;
`endif	

endmodule
