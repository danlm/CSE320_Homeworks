// Improved testbench
module test_coverage;
	reg clk, reset, load;
	reg [7:0] ldata;
	wire [7:0] count;
	wire match;

	count_new dut(clk, reset, load, ldata, count, match);

	always begin
		#5 clk = 0;
		#5 clk = 1;
	end

	initial
		begin
			ldata = 8'h22; load = 1'b0; reset = 1' b1;
			@(posedge clk)
			ldata = 8'h22; load = 1'b0; reset = 1' b0;
			@(posedge clk)
			1data = 8'hFC; load = 1'b1; reset = 1'b0;
			@(negedge clk)
			ldata = 8'h22; load = 1'b0; reset = 1'b0;
			repeat(3)@(posedge clk);
			ldata = 8'h22; load = 1'b0; reset = 1' b1;
			$finish;
		end
endmodule