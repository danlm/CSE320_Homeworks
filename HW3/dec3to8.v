// File name: dec3to8.v
// Description: A behavioral 3 to 8 decoder.

module dec3to8(input wire [2:0] A,
                        output reg [0:7] Y    );

  always @ (A) begin
    case (A)
        0: Y = 8'b10000000;
        1: Y = 8'b01000000;
        2: Y = 8'b00100000;
        3: Y = 8'b00010000;
        4: Y = 8'b00001000;
        5: Y = 8'b00000100;
        6: Y = 8'b00000010;
        7: Y = 8'b00000001;
        default: Y = 8'b00000000;
      endcase
  end
endmodule