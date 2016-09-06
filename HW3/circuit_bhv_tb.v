// File name: circuit_bhv_tb.v
// Description: Test bench for given circuit.

`timescale 1ns / 1ns

module circuit_test;
	
        // Inputs
        reg x1;
        reg x2;
        reg x3;
	reg x4;

        // Outputs
        wire z1;

        integer i;
       
        // Instantiate the Unit Under Test (UUT)
        circuit_bhv uut (
                .x1(x1),
                .x2(x2),
                .x3(x3),
                .x4(x4),
                .z1(z1)
        );

        initial begin
                // Initialize Inputs
                x1 = 0;
                x2 = 0;
                x3 = 0;
                x4 = 0;
        end

        always @ (x1 or x2 or x3 or x4)
                begin
       		$dumpfile("circuit.vcd");
		$dumpvars;
                // generate truth table
                for ( i = 0; i < 16; i = i + 1 )
                        // every 10 ns set inputs to the binary rep. of i
                        #10 {x1, x2, x3, x4} = i;
                       
                // stop 10ns after last change of inputs
                #10 $stop;
                end

     
endmodule