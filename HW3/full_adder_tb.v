// File name: full_adder_tb.v
// Description: 1-bit full adder testbench

`timescale 1ns / 1ns

module test;
	
        // Inputs
        reg a;
        reg b;
        reg cin;

        // Outputs
        wire sum;
        wire cout;

        integer i;
       
        // Instantiate the Unit Under Test (UUT)
        full_adder uut (
                .a(a),
                .b(b),
                .cin(cin),
                .sum(sum),
                .cout(cout)
        );

        initial begin
                // Initialize Inputs
                a = 0;
                b = 0;
                cin = 0;
        end

        always @ ( a or b or cin )
                begin
       		$dumpfile("adder.vcd");
		$dumpvars;
                // generate truth table
                for ( i = 0; i < 8; i = i + 1 )
                        // every 10 ns set a, b, and cin to the binary rep. of i
                        #10 {a, b, cin} = i;
                       
                // stop 10ns after last change of inputs
                #10 $stop;
                end

     
endmodule