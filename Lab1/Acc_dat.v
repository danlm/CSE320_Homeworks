// File name: Acc_dat.v
// Student Name: Daniel Martin
// Description: Dataflow Adder-accumulator for 4-bit cpu

`timescale 1ns / 1ns

module DFF(

input wire clk,

input wire reset,

input wire ce,

input wire d,

output wire q);


FDRE FDRE_inst (

.Q(q), // 1-bit Data output

.C(clk), // 1-bit Clock input

.CE(ce), // 1-bit Clock enable input

.R(reset), // 1-bit Synchronous reset input

.D(d) // 1-bit Data input

);

endmodule

module Adder_Accumulator_dat(
    input wire [3:0] D,
    input wire ADD,
    input wire SUB,
    input wire LD,
    input wire CLB,
    input wire CLC,
    input wire INC,
    input wire CMC,
    input wire CMA,
    input wire RAL,
    input wire RAR,
    input wire TCC,
    input wire DAC,
    input wire STC,
	 input wire RST,
	 input wire X2,
	 input wire clk,
    output wire [3:0] ACC,
	 output wire carry
    );
	 
	FDRE FDRE_inst (

.Q(q), // 1-bit Data output

.C(clk), // 1-bit Clock input

.CE(ce), // 1-bit Clock enable input

.R(reset), // 1-bit Synchronous reset input

.D(d) // 1-bit Data input

);
	 
	 wire [4:0] sum, dif, ld, clr, cla, ina, cpc, cpa, rol, ror, tra, rec, sec;
	 
	 assign sum = ADD ? ({1'b0, D} + {carry, ACC}) : {carry, ACC};
	 assign dif = SUB ? ({carry, ACC} - {1'b0, D}) : sum; /* Instruction Doc says to complement carry - doesn't sound right.*/
	 assign ld = LD ? ({1'b0, D}) : dif;
	 assign cla = CLB ? 5'b00000 : ld;
	 assign clr = CLC ? {1'b0, ACC} : cla;
	 assign ina = INC ? ({carry, ACC} + 1'b1) : clr;
	 assign cpc = CMC ? ({~carry, ACC}) : ina;
	 assign cpa = CMA ? ({~carry, ~ACC}) : cpc;
	 assign rol = RAL ? ({ACC, carry}) : cpa;
	 assign ror = RAR ? ({ACC[0],carry,ACC[3:1]}) : rol;
	 assign tcc = TCC ? ({4'b0000, carry}) : ror;
	 assign dac = DAC ? ({carry, ACC} - 1'b1) : tcc;
	 assign stc = STC ? ({1'b1, ACC}) : dac;
	 
	 DFF DFF0(clk, RST, X2, stc[4], carry);
	 DFF DFF1(clk, RST, X2, stc[3], ACC[3]);
	 DFF DFF2(clk, RST, X2, stc[2], ACC[2]);
	 DFF DFF3(clk, RST, X2, stc[1], ACC[1]);
	 DFF DFF4(clk, RST, X2, stc[0], ACC[0]);

endmodule
