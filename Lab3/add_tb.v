`timescale 1ns / 1ns

module add_tb;

	// Inputs
	reg [31:0] a;
	reg [31:0] b;

	// Outputs
	wire cout;
	wire [31:0] sum;
	
	// Iterator
	integer i, seed, rand_value;

	// Instantiate the Unit Under Test (UUT)
	alu_add uut (
		.a(a), 
		.b(b), 
		.cout(cout), 
		.sum(sum)
	);

	task checkS;
	    input i, j, S;
	    integer i, j, s_i;
	    reg [31:0] S;
	    begin
	      s_i = i+j;
	      if (S !== s_i) begin
		$display($time," Error: i=%d, j=%d, expected %d (%16b), got %d (%16b)", i, j, s_i, s_i, S, S); 
		$stop(1); 
		end
	    end
	 endtask

	initial
		seed = 2;
	
	initial begin
		// Corner Cases	
		a = 0;
		b = 0;

		#10
		checkS(a,b,sum);
		a = 32'hFFFFFFFF;
		b = 32'h00000000;
		
		#10
		checkS(a,b,sum);
		a = 32'hFFFFFFFF;
		b = 32'hFFFFFFFF;
		
		#10
		checkS(a,b,sum);
		a = 32'h00000000;
		b = 32'hFFFFFFFF;
		
		#10
		checkS(a,b,sum);
		a = 0;
		b = 0;
		// Toggle Coverage		
		for(i = 0; i < 32; i = i + 1) begin
				a[i] = 1'b1;
			#5	a[i] = 1'b0;
		end
		#10
		checkS(a,b,sum);
		for(i = 0; i < 32; i = i + 1) begin
				b[i] = 1'b1;
			#5	b[i] = 1'b0;
		end
		#10
		checkS(a,b,sum);
		// Random Testing
		for(i = 0; i < 32; i = i + 1) begin
			#5 rand_value = $random(seed);
			if(rand_value < 32'hFFFFFFFF || rand_value > 32'hFFFFFFFF)
				a = rand_value;
			
			rand_value = $random(seed);
			if(rand_value < 32'hFFFFFFFF || rand_value > 32'hFFFFFFFF)
				b = rand_value;
		end
		#10
		checkS(a,b,sum);
		$finish();
		
	end
      
endmodule

