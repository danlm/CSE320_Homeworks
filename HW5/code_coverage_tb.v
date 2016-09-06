module code_coverage_tb;
    parameter REG_WIDTH = 4;
    wire[REG_WIDTH-1:0] A_o;
    wire ODD_o, EVEN_o;
    reg[REG_WIDTH-1:0] D_i;
    reg DIRECTION_i, clk, reset;

    code_coverage i_dut (A_o, DIRECTION_i,
    ODD_o, EVEN_o, clk, reset, D_i);
    
    
//	$dumpfile("code_coverage.vcd");
//	$dumpvars;

    initial
	fork
		begin // Generate Clock
			forever #5 clk = ~clk;
		end

		begin // Initialize Inputs
			clk = 1;
			reset = 1;
			DIRECTION_i = 0;
			#9 reset = 0;
		end

		begin // Provide stimulus
		// Code for coverage
			# 19 DIRECTION_i = 1;
		end
	join
endmodule