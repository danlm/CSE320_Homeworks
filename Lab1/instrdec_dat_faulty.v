// File name: instrdec_dat.v
// Student Name: Daniel Martin
// Description: Dataflow Instruction Decoder for 4-bit cpu

`timescale 1ns / 1ns

module instrdec_dat (input wire [3:0] opr, opa,
		output wire clb, clc, iac, add);
	
	assign add = (opr == 4'b 1000) ? 1 : 0;
  	assign clb = (& opr) & (! opa);
  	assign clc = ((& opr) &  (opa == 4'b 0001)) ? 1 : 0;
  	assign iac = ((& opr) &  (opa == 4'b 0010)) ? 1 : 0;
  endmodule