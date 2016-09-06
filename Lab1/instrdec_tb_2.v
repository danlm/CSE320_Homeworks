// File name: instrdec_tb.v
// Student Name: Daniel Martin
// Description: Instruction Decoder testbench for behavioral and dataflow

`timescale 1ns / 1ns

module Testbench;

   // Input
   reg [3:0] opr, opa;
   
   // Output
   wire clb, clc, iac, cmc, cma, ral, rar, tcc, dac, stc, add, sub, ld, nop;

   integer i;

    // Instantiate the Unit Under Test (UUT) - change the name for each module
  instrdec_dat uut (
          .opr(opr),
          .opa(opa),
          .clb(clb),
          .clc(clc),
	  .iac(iac),
	  .cmc(cmc),
	  .cma(cma),
	  .ral(ral),
	  .rar(rar),
	  .tcc(tcc),
	  .dac(dac),
	  .stc(stc),
          .add(add),
	  .sub(sub),
	  .ld(ld),
	  .nop(nop)
  );
   

   
   initial 
      begin
      $dumpfile("instrdec_dat.vcd"); // Again, change this name as needed
      $dumpvars;
      
      //nop
      opr = 4'b0000; opa = 4'b0000;
      
      //add
      #10 opr = 4'b1000; opa = 4'b0010;

      //sub
      #10 opr = 4'b1001; opa = 4'b0010;

      //ld
      #10 opr = 4'b1010; opa = 4'b0000;

     //clb
     #10 opr = 4'b1111; opa = 4'b0000;
	  
      // generate truth table
	for ( i = 0; i <= 9; i = i + 1 )
	// every 10 ns set opa to the binary rep. of i
	   #10 opa = i;
      	  
                       
      // stop 10ns after last change of inputs
      #10 $stop;
       
   end
   
endmodule
