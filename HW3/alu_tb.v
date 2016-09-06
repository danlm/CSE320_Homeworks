// File name: alu_tb.v
// Description: Testbench for ALU.

`timescale 1ns / 1ns
module alu_test;
  
  // Input
  reg [3:0] a;
  reg [3:0] b;
  reg [2:0] sel;
  
  // Output
  wire [3:0] c;
  
  integer i;

  // Instantiate the Unit Under Test (UUT)
  ALU_bhv uut (a, b, sel, c);
  
  initial begin
                // Initialize Inputs
                a = 4'b0101;
                b = 4'b0010;
                sel = 3'b000;
        end
  
  always @ (a or b or sel) begin
	$dumpfile("alu.vcd");
	$dumpvars;
         // generate truth table
         for ( i = 0; i < 5; i = i + 1 )
		// every 10 ns set A to the binary rep. of i
                  #10 sel = i;
         // stop 10ns after last change of inputs
         #10 $stop;
         end
endmodule
