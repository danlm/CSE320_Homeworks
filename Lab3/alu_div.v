module alu_div
	#(parameter WORD_WIDTH = 32, BLOCK_WIDTH = 4)
    (input  wire [WORD_WIDTH-1:0]  a,
	  input  wire [WORD_WIDTH-1:0]  b,
	  output wire [WORD_WIDTH-1:0]  div);

`define GCD

`ifdef GCD
	reg[WORD_WIDTH-1:0] A, B, out, swap;
	wire[WORD_WIDTH-1:0] B_n, D;
	reg done;
	wire r1, r2;
	// Adders to use
	alu_add comp_2(~B, 1'b1, r1, B_n); // 2's complement of a
	alu_add diff(A, B_n, r2, D);  // A-B
	
	always @* begin
		done = 1'b0; A = a; B = b;
		while( !done )
		begin
			if( A < B ) begin
				swap = A;
				A = B; 
				B = swap;
			end
			else if( B != 0 ) begin
				A = D;
			end
			else begin
				done = 1'b1; // Returns A if B=0
			end
		end
		out = A;
	end
	assign div = out;
	

	/*reg[WORD_WIDTH-1:0] quotient;
	reg [(2*WORD_WIDTH)-1:0] scaled_divider, temp_remainder, temp_result;
	integer i;
	wire s, t, r1, r2;

	alu_add comp_2(~scaled_divider, 1'b1, r1, s); // 2's complement of a
	alu_add diff(temp_remainder, s, r2, t);  // A-B

	always @(dividend or divider) begin
		scaled_divider = {1'b0, b, 0};
		temp_remainder = {0, a};

		for(i = 0;i < WORD_WIDTH; i = i + 1) begin
			temp_result = t;

			if(temp_result[((2*WORD_WIDTH)-1) - i]) begin // Negative result, Quotient set to '0'
				quotient[(WORD_WIDTH-1) - i] = 1'b0;
			end
			else begin // Positive result, Quotient set to '1'
				quotient[(WORD_WIDTH-1) - i] = 1'b1;
				temp_remainder = temp_result;
			end

			scaled_divider = scaled_divider >> 1;
		end

	end
	assign div = quotient;*/
	
`else
	assign div = a / b;
`endif	

endmodule
