// File name: dec3to8_tb.v
// Description: Testbench for decoder

`timescale 1ns / 1ns
module tester;
  
  // Input
  reg [2:0] A;
  
  // Output
  wire [0:7] Y;
  
  integer i;

  // Instantiate the Unit Under Test (UUT)
  dec3to8 uut (
          .A(A),
          .Y(Y)
  );
  
  initial begin
                // Initialize Input
                A = 3'b000;
        end
  
  always @ (A) begin
	$dumpfile("dec.vcd");
	$dumpvars;
         // generate truth table
         for ( i = 0; i < 8; i = i + 1 )
		// every 10 ns set A to the binary rep. of i
                  #10 A = i;
                       
         // stop 10ns after last change of inputs
         #10 $stop;
         end
endmodule