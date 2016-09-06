// Improved testbench
module test_counter1;
	reg up, load, clk, reset;
	reg [15:0] load_data;
	wire [15:0] count;

	always begin // generate clock
		#5 clk =0;
		#5 clk =1;
	end

	// instantiate device under test
	countc dut( .clock(clk), .reset(reset), .up(up), .load(load),.load_data(load_data), .count(count));
	
	initial begin // counter test sequence
		reset = 1;
		@(posedgeclk) #3 if (count !== 16'h0000)
			begin
				$display("Counter reset error");
				$finish;
			end

		reset = 0; load = 1; up = 0; load_data = 'hF;
		@(posedgeclk) #3 if (count !== 16'h000F)
			begin
				$display("Counter load error");
				$finish;
			end

		reset = 1;
		@(posedgeclk) #3 if (count !== 16'h0000)
			begin
				$display("Counter reset error");
				$finish;
			end

		reset = 0; load = 0; up = 0;
		@(posedgeclk) #3 if (count !== 16'hFFFF)
			begin
				$display("Counter decrement error");
				$finish;
			end
		
		reset = 0; load = 0; up = 1;
		@(posedgeclk) #3 if (count !== 16'h0000)
			begin
				$display("Counter increment error");
				$finish;
			end
		
		
		
		$finish;
	end
endmodule