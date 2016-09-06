// File name: fctn.v
// Description: AND between bits of a 4-bit input

//behavioral function
module fctn(x, z1);

input [3:0] x;
output z1;

reg z1;

always @ (x)
begin
	z1 = & x;
end
endmodule