// File name: instrdec_tb.v
// Student Name: Daniel Martin
// Description: Instruction Decoder testbench for behavioral and dataflow

`timescale 1ns / 1ns

module Testbench;

   // Input
   reg [3:0] opr, opa;
   
   // Output
   wire clb, clc, iac, add;

    // Instantiate the Unit Under Test (UUT) - change the name for each module
  instrdec_str uut (
          .opr(opr),
          .opa(opa),
          .clb(clb),
          .clc(clc),
          .iac(iac),
          .add(add) 
  );
   

   
   initial 
      begin
      $dumpfile("instrdec_str.vcd"); // Again, change this name as needed
      $dumpvars;
      
      //add
      opr = 4'b1000; opa = 4'b0010;
      
	  
      //iac
      #10 opr = 4'b1111; opa = 4'b0010;
      
	  
      //clc
      #10 opr = 4'b1111; opa = 4'b0001;
      
	  
      //clb
      #10 opr = 4'b1111; opa = 4'b0000;
      
       #10 $stop;
       
   end
   
endmodule
