module code_coverage
	#(parameter REG_WIDTH = 8)
	(output reg [REG_WIDTH-1:00] A,
	input wire DIRECTION,
	output reg ODD, EVEN,
	input CLK, RESET,
	input [REG_WIDTH-1:00] D);

	always@(posedge CLK or posedge RESET)
		if (RESET == 1'b1)
			A <= 'd0;
		else
			A <= DIRECTION ? A + 1 : A-1;

	always@*
		if (A[0])
			EVEN = 1'b0;
		else
			EVEN = 1'b1;

	always@*
		if (A[0])
			ODD = 1'b1;
		else
			ODD = 1'b0;
endmodule