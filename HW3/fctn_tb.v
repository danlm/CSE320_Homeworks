// File name: fctn_tb.v
// Description: AND between bits of a 4-bit input - testbench

`timescale 1ns / 1ns

module test;
	
        // Inputs
        reg [3:0] x;

        // Outputs
        wire z1;

        integer i;
       
        // Instantiate the Unit Under Test (UUT)
       fctn uut (
                .x(x),
                .z1(z1)
        );

        initial begin
                // Initialize Inputs
                x = 4'b0000;
        end

        always @ ( x )
                begin
       		$dumpfile("fctn.vcd");
		$dumpvars;
                // generate truth table
                for ( i = 0; i < 16; i = i + 1 )
                        // every 10 ns set x to the binary rep. of i
                        #10 x = i;
                       
                // stop 10ns after last change of inputs
                #10 $stop;
                end

     
endmodule