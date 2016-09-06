`timescale 1 ns / 1 ns

module handshake_tb;

  // Input
  reg DataA, ReqA, clkA, clkB, ResetA, ResetB;

  // Output
  wire AckA, ReqB, DataB;

  // Generate clock A
  always begin
      #2 clkA = 0;
      #2 clkA = 1;
  end
  
    // Generate clock B
  always begin
      #3 clkB = 0;
      #3 clkB = 1;
  end

  // Instantiate the Unit Under Test (UUT)
  handshake uut(.DataA(DataA), .ReqA(ReqA), .clkA(clkA), .clkB(clkB), .ResetA(ResetA), .ResetB(ResetB), .AckA(AckA), .ReqB(ReqB), .DataB(DataB));

  initial begin
    // Initialize Inputs
    DataA = 1'b1;
    ReqA = 1'b0;
	 ResetA = 1'b0;
	 ResetB = 1'b0;

    @ (posedge clkA) begin
		ReqA = 1'b1;
		ResetA = 1'b1;
		ResetB = 1'b1;
    end

    @ (posedge clkA) begin
		ReqA = 1'b0;
    end
  end

endmodule