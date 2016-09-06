// File name: instrdec_str.v
// Student Name: Daniel Martin
// Description: Structural Instruction Decoder for 4-bit cpu

`timescale 1ns / 1ns

module instrdec_str (input wire [3:0] opr, opa,
		output wire clb, clc, iac, add);
	
	// Inverted versions of opr bits
	not(r_n2, opr[2]);
	not(r_n1, opr[1]);
	not(r_n0, opr[0]);

	// Inverted versions of opa bits
	not(a_n3, opa[3]);
	not(a_n2, opa[2]);
	not(a_n1, opa[1]);
	not(a_n0, opa[0]);
	
	// Add
	and(add, opr[3],r_n2,r_n1,r_n0);
	
	// Bitwise AND of opr bits - used for other 3 instructions
	and(opr_c, opr[3], opr[2], opr[1], opr[0]);
	
	// If OPA = 0000
	and(opa_0, a_n3, a_n2, a_n1, a_n0);
	and (clb, opr_c, opa_0);
	
	// If OPA = 0001
	and(opa_1, a_n3, a_n2, a_n1, opa[0]);
	and (clc, opr_c, opa_1);
	
	// If OPA = 0010
	and(opa_2, a_n3, a_n2, opa[1], a_n0);
	and (iac, opr_c, opa_2);
  
  endmodule

