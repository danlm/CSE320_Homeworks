module countc(clock, reset, load, up, load_data, count);
	input clock,reset, load, up;
	input [15:0] load_data;
	output [15:0] count;

	reg [15:0] count;

	always @(posedge clock)
		if (reset)
			count <= 8'b0;
		else 
			if (load)
				count <= #1 load_data;
			else
				if (up)
					count <= #1 count + 1;
				else
					count <= #1 count - 1;
endmodule