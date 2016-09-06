`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:40:35 12/14/2014
// Design Name:   alu_div
// Module Name:   C:/Users/dlmart11/Desktop/Lab03/ALU/div_tb.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu_div
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module div_tb;

	// Inputs
	reg [31:0] a;
	reg [31:0] b;

	// Outputs
	wire [31:0] div;

	// Instantiate the Unit Under Test (UUT)
	alu_div uut (
		.a(a), 
		.b(b), 
		.div(div)
	);

	// Iterator
	integer i, seed, rand_value;

	task checkQ;
	    input i, j, Q;
	    integer i, j, quo;
	    reg [31:0] Q;
	    begin
	      quo = i / j;
	      if (Q !== quo) begin
		$display($time," Error: i=%d, j=%d, expected %d (%16b), got %d (%16b)", i, j, quo, quo, Q, Q); 
		$stop(1); 
		end
	    end
	 endtask

	
	initial
		seed = 2;
	
	initial begin
		$dumpfile("div.vcd");
	$dumpvars;
		// Corner Cases	
		a = 0;
		b = 0;

		#10
		a = 32'h7FFFFFFF;
		b = 32'h80000000;
		
		#10
		checkQ(a,b,div);
		a = 32'h7FFFFFFF;
		b = 32'h7FFFFFFF;
		
		#10
		checkQ(a,b,div);
		a = 32'h80000000;
		b = 32'h7FFFFFFF;

		#10
		checkQ(a,b,div);
		a = 32'h80000000;
		b = 32'h80000000;
		
		#10
		checkQ(a,b,div);
		a = 0;
		b = 0;
		// Toggle Coverage		
		for(i = 0; i < 32; i = i + 1) begin
				a[i] = 1'b1;
			#5	a[i] = 1'b0;
		end
		#10
		checkQ(a,b,div);
		for(i = 0; i < 32; i = i + 1) begin
				b[i] = 1'b1;
			#5	b[i] = 1'b0;
		end
		#10
		checkQ(a,b,div);
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
		checkQ(a,b,div);
		$finish();
		
	end
      
endmodule

