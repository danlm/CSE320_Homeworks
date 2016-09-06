`timescale 1ns / 1ps

module WM_tb();
	
	reg [3:0] a;
	reg [3:0] b;

	reg [7:0] out;
	
	WM_4x4 wallace(a, b, out);
	
	integer i, x, y;
	
	initial begin
		#10
		a = 4'b1001;
		b = 4'b1001;
		
		#10
		
		for(x = 0; x < 15; x = x + 1) begin
			for(y = 0; y < 15; y = y + 1) begin
				$display("value of 'p[%d][%d]': %d", x, y, wallace.p[x][y]);
			end
		end
		
		for(i = 0; i < 28; i = i + 1) begin
			$display("value of 'c%d': %d", i, wallace.c[i]);
		end
		
		$display("value of wallace output wires: %b", {wallace.c[29], wallace.c[25], wallace.c[23], wallace.c[21], wallace.c[19], wallace.c[10], wallace.c[0], wallace.c[27]});
		$display("value of 'wallace.out': %d", wallace.out);
		$display("value of 'a': %d", a);
		$display("value of 'b': %d", b);
		$display("value of 'out': %d", out);
	end
endmodule
