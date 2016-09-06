module count_new(clk, reset, load, ldata, count, match);
	input clk, reset, load;
	input [7:0] ldata;
	output [7:0] count; reg[7:0] count;
	output match;

	reg match;

	always @(posedge clk or posedge reset)
		if(reset)
			count <= #1 8'h00;
		else
			if(load)
				count <= #1 ldata;
			else
				count <= #1 count + 8'h01;

	always @count
		if(count==ldata)
			match = 1'b1;
		else
			match = 1'b0;
endmodule