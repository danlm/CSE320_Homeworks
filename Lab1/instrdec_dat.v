// File name: instrdec_dat.v
// Student Name: Daniel Martin
// Description: Dataflow Instruction Decoder for 4-bit cpu

`timescale 1ns / 1ns

module instrdec_dat (input wire [3:0] opr, opa,
		output wire clb, clc, iac, cmc, cma, ral, rar, tcc, dac, stc, add, sub, ld, nop);
	
	assign nop = (! opr) & (! opa);

	assign add = opr[3] & ~opr[2] & ~opr[1] & ~opr[0];
	assign sub = opr[3] & ~opr[2] & ~opr[1] & opr[0];
	assign ld = opr[3] & ~opr[2] & opr[1] & ~opr[0];
	
	// In case OPR = 1111
	assign clb = (&opr) & (! opa);
	assign clc = (&opr) & ~opa[3] & ~opa[2] & ~opa[1] & opr[0];
	assign iac = (&opr) & ~opa[3] & ~opa[2] & opa[1] & ~opr[0];
	assign cmc = (&opr) & ~opa[3] & ~opa[2] & opa[1] & opr[0];
	assign cma = (&opr) & ~opa[3] & opa[2] & ~opa[1] & ~opr[0];
	assign ral = (&opr) & ~opa[3] & opa[2] & ~opa[1] & opr[0];
	assign rar = (&opr) & ~opa[3] & opa[2] & opa[1] & ~opr[0];
	assign tcc = (&opr) & ~opa[3] & opa[2] & opa[1] & opr[0];
	assign dac = (&opr) & opa[3] & ~opa[2] & ~opa[1] & ~opr[0];
	assign stc = (&opr) & opa[3] & ~opa[2] & opa[1] & ~opr[0];
	
  endmodule