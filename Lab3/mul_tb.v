`timescale 1ns / 1ns

module mul_tb;

	// Inputs
	reg [31:0] a;
	reg [31:0] b;

	// Outputs
	wire [63:0] mul;
	
	// Iterator
	integer i, seed, rand_value;

	// Instantiate the Unit Under Test (UUT)
	alu_mul uut (
		.a(a), 
		.b(b), 
		.mul(mul)
	);

	/*task checkP;
	    input i, j, P;
	    integer i, j, prod;
	    reg [63:0] P;
	    begin
	      prod = i*j;
	      if (P !== prod) begin
		$display($time," Error: i=%d, j=%d, expected %d (%16b), got %d (%16b)", i, j, prod, prod, P, P); 
		$stop(1); 
		end
	    end
	 endtask*/

	
	initial
		seed = 2;
	
	initial begin
		$dumpfile("mul.vcd");
	$dumpvars;
		// Corner Cases	
		a = 0;
		b = 0;

		#10
		//checkP(a,b,mul);
		a = 32'h7FFFFFFF;
		b = 32'h80000000;
		
		#10
		//checkP(a,b,mul);
		a = 32'h7FFFFFFF;
		b = 32'h7FFFFFFF;
		
		#10
		//checkP(a,b,mul);
		a = 32'h80000000;
		b = 32'h7FFFFFFF;

		#10
		//checkP(a,b,mul);
		a = 32'h80000000;
		b = 32'h80000000;
		
		#10
		//checkP(a,b,mul);
		a = 0;
		b = 0;
		// Toggle Coverage		
		for(i = 0; i < 32; i = i + 1) begin
				a[i] = 1'b1;
			#5	a[i] = 1'b0;
		end
		#10
		//checkP(a,b,mul);
		for(i = 0; i < 32; i = i + 1) begin
				b[i] = 1'b1;
			#5	b[i] = 1'b0;
		end
		#10
		//checkP(a,b,mul);
		// Random Testing
		for(i = 0; i < 32; i = i + 1) begin
			#5 rand_value = $random(seed);
			if(rand_value < 32'h7FFFFFFF || rand_value > 32'h80000000)
				a = rand_value;
			
			rand_value = $random(seed);
			if(rand_value < 32'h7FFFFFFF || rand_value > 32'h80000000)
				b = rand_value;
		end
		#10
		//checkP(a,b,mul);
		$finish();
		
	end
      
endmodule

