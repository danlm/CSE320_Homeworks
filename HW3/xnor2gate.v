// File name: xnor2gate.v
// Description: 2-input XNOR gate


`timescale 1ns / 1ns

module XNOR2gate(input wire A, B,
		output reg F);

   always @ (A or B)
   begin
      F <= A ~^ B;
   end

endmodule