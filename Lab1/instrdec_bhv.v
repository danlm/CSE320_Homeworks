// File name: instrdec_bhv.v
// Student Name: Daniel Martin
// Description: Behavioral Instruction Decoder for 4-bit cpu

`timescale 1ns / 1ns

module instrdec_bhv (input wire [3:0] opr, opa,
		output reg clb, clc, iac, add);
	
	always @ (opa or opr)
		begin
		case (opr)
		   	4'b1111: begin 
		   		  case (opa)
		   			4'b0000: begin add = 0; clb = 1; clc = 0; iac = 0; end
		   			4'b0001: begin add = 0; clb = 0; clc = 1; iac = 0; end
		   			4'b0010: begin add = 0; clb = 0; clc = 0; iac = 1; end
		   			default: begin add = 0; clb = 0; clc = 0; iac = 0; end
		   		  endcase
		   		  end
		   	4'b1000: begin add = 1; clb = 0; clc = 0; iac = 0; end
		   	default: begin add = 0; clb = 0; clc = 0; iac = 0; end
		endcase
		end
  
  endmodule