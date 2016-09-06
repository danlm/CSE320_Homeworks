module handshake
	(input wire DataA, ReqA, clkA, clkB, ResetA, ResetB,
	output reg DataB,
	output wire AckA, ReqB);
	
	// Temporary storage
	reg Req, Ack, r1, r2, r3, a1, a2, a3;
	
	// Asynchronous outputs
	assign AckA = a3 ^ a2;
	assign ReqB = r3 ^ r2;

	// System A
	always@(posedge clkA or negedge ResetA) begin
		if (~ResetA) begin
			a1 <= 0;
			a2 <= 0;
			a3 <= 0;

			Req <= 0;
		end
		else begin
			Req <= (ReqA ^ Req);
			a1 <= Ack;
			a2 <= a1;
			a3 <= a2;
		end
	end

	// System B
	always@(posedge clkB or negedge ResetB) begin
		if (~ResetB) begin
			r1 <= 0;
			r2 <= 0;
			r3 <= 0;

			Ack <= 0;
		end
		else begin
			if (ReqB == 1'b1) begin
				DataB <= DataA;
			end
			r1 <= Req;
			r2 <= r1;
			r3 <= r2;
			Ack <= (ReqB ^ Ack);
		end
	end
endmodule