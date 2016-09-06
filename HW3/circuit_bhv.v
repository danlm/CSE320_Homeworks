// File name: circuit_bhv.v
// Description: z1 = x1x2 + x3x4

`timescale 1ns / 1ns

module circuit_bhv(input wire x1, x2, x3, x4,
		output reg z1);

   always @ (x1 or x2 or x3 or x4)
   begin
      z1 = (x1 & x2) | (x3 & x4);
   end

endmodule  