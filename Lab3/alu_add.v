module alu_add
	#(parameter WORD_WIDTH = 32)
    (input  wire [WORD_WIDTH-1:0] a,
	  input  wire [WORD_WIDTH-1:0] b,
	  output wire                  cout,
	  output wire [WORD_WIDTH-1:0] sum);

`define CSA_32x16

`ifdef RCA_32x1
// The basic idea of the RCA is to let each adder compute a carry and forward
// it to a subsequent adder.
	wire [WORD_WIDTH:0] carry;
	assign carry[0] = 0;
	assign cout = carry[WORD_WIDTH];
	genvar i;
	generate 
		for (i = 0; i < WORD_WIDTH; i = i + 1) begin: RCA_32x1
			fa
				i_fa (
					.A(a[i]), 
					.B(b[i]), 
					.Sum(sum[i]),  
					.Cin(carry[i]), 
					.Cout(carry[i+1]));
		end
	endgenerate		
`elsif CBA_32x4

	wire [WORD_WIDTH:0] carry;
	wire [WORD_WIDTH-1:0] P;
	wire [WORD_WIDTH-1:0] G;
	wire [7:0] sel;
	assign carry[0] = 0;
	assign cout = carry[WORD_WIDTH];
	genvar i, j;
	generate 
		for (i = 0; i < WORD_WIDTH; i = i + 4) begin: CBA_32x4
				p_and_g_4
					i_p_and_g_4_CBA(
						.A(a[i+3:i]),
						.B(b[i+3:i]),
						.P(P[i+3:i]),
						.G(G[i+3:i]));
				cp_4
					i_cp_4_CBA(
						.P(P[i+3:i]),
						.G(G[i+3:i]),
						.Cin(carry[i]),
						.Cout(carry[i+3]),
						.Sum(sum[i+3:i]));
				
				assign sel[i / 4] = &P[i+3:i];
				
				assign carry[i+4] = sel ? carry[i] : carry[i+3];
				
		end
	endgenerate	


`elsif CBA_32x8

	wire [WORD_WIDTH:0] carry;
	wire [WORD_WIDTH-1:0] P;
	wire [WORD_WIDTH-1:0] G;
	wire [3:0] sel;
	assign carry[0] = 0;
	assign cout = carry[WORD_WIDTH];
	genvar i;
	generate 
		for (i = 0; i < WORD_WIDTH; i = i + 8) begin: CBA_32x8
				p_and_g_8
					i_p_and_g_8_CBA(
						.A(a[i+7:i]),
						.B(b[i+7:i]),
						.P(P[i+7:i]),
						.G(G[i+7:i]));
				cp_8
					i_cp_8_CBA(
						.P(P[i+7:i]),
						.G(G[i+7:i]),
						.Cin(carry[i]),
						.Cout(carry[i+7]),
						.Sum(sum[i+7:i]));
				
				assign sel[i / 8] = &P[i+7:i];
				
				assign carry[i+8] = sel ? carry[i] : carry[i+7];
				
		end
	endgenerate	

`elsif CBA_32x16

	wire [WORD_WIDTH:0] carry;
	wire [WORD_WIDTH-1:0] P;
	wire [WORD_WIDTH-1:0] G;
	wire [1:0] sel;
	assign carry[0] = 0;
	assign cout = carry[WORD_WIDTH];
	genvar i;
	generate 
		for (i = 0; i < WORD_WIDTH; i = i + 16) begin: CBA_32x16
				p_and_g_16
					i_p_and_g_16_CBA(
						.A(a[i+15:i]),
						.B(b[i+15:i]),
						.P(P[i+15:i]),
						.G(G[i+15:i]));
				cp_16
					i_cp_16_CBA(
						.P(P[i+15:i]),
						.G(G[i+15:i]),
						.Cin(carry[i]),
						.Cout(carry[i+15]),
						.Sum(sum[i+15:i]));
				
				assign sel[i / 16] = &P[i+15:i];
				
				assign carry[i+16] = sel ? carry[i] : carry[i+15];
				
		end
	endgenerate
	
`elsif CSA_32x4
	wire [(WORD_WIDTH/4):0] carry;
	wire [(WORD_WIDTH/4)-1:0] c0, c1;
	wire [WORD_WIDTH-1:0] s0, s1;
	wire [WORD_WIDTH-1:0] P;
	wire [WORD_WIDTH-1:0] G;
	assign carry[0] = 0;
	assign cout = carry[WORD_WIDTH/4];
	genvar i;
	generate 
		for (i = 0; i < (WORD_WIDTH/4); i = i + 1) begin: CSA_32x4
				p_and_g_4
					i_p_and_g_4_CSA(
						.A(a[4*i+3:4*i]),
						.B(b[4*i+3:4*i]),
						.P(P[4*i+3:4*i]),
						.G(G[4*i+3:4*i]));
				cp_4
					i_cp_4_0_CSA(
						.P(P[4*i+3:4*i]),
						.G(G[4*i+3:4*i]),
						.Cin(1'b0),
						.Cout(c0[i]),
						.Sum(s0[4*i+3:4*i]));
				cp_4
					i_cp_4_1_CSA(
						.P(P[4*i+3:4*i]),
						.G(G[4*i+3:4*i]),
						.Cin(1'b1),
						.Cout(c1[i]),
						.Sum(s1[4*i+3:4*i]));
				
			assign carry [i+1] = carry[i] ? c1[i] : c0[i];	
			assign sum [4*i+3:4*i] = carry[i] ? s1[4*i+3:4*i]:s0[4*i+3:4*i];
				
		end
	endgenerate

`elsif CSA_32x8
	wire [(WORD_WIDTH/8):0] carry;
	wire [(WORD_WIDTH/8)-1:0] c0, c1;
	wire [WORD_WIDTH-1:0] s0, s1;
	wire [WORD_WIDTH-1:0] P;
	wire [WORD_WIDTH-1:0] G;
	assign carry[0] = 0;
	assign cout = carry[WORD_WIDTH/8];
	genvar i;
	generate 
		for (i = 0; i < (WORD_WIDTH/8); i = i + 1) begin: CSA_32x8
				p_and_g_8
					i_p_and_g_8_CSA(
						.A(a[8*i+7:8*i]),
						.B(b[8*i+7:8*i]),
						.P(P[8*i+7:8*i]),
						.G(G[8*i+7:8*i]));
				cp_8
					i_cp_8_0_CSA(
						.P(P[8*i+7:8*i]),
						.G(G[8*i+7:8*i]),
						.Cin(1'b0),
						.Cout(c0[i]),
						.Sum(s0[8*i+7:8*i]));
				cp_8
					i_cp_8_1_CSA(
						.P(P[8*i+7:8*i]),
						.G(G[8*i+7:8*i]),
						.Cin(1'b1),
						.Cout(c1[i]),
						.Sum(s1[8*i+7:8*i]));
				
			assign carry [i+1] = carry[i] ? c1[i] : c0[i];	
			assign sum [8*i+7:8*i] = carry[i] ? s1[8*i+7:8*i]:s0[8*i+7:8*i];
				
		end
	endgenerate

`elsif CSA_32x16
	wire [(WORD_WIDTH/16):0] carry;
	wire [(WORD_WIDTH/16)-1:0] c0, c1;
	wire [WORD_WIDTH-1:0] s0, s1;
	wire [WORD_WIDTH-1:0] P;
	wire [WORD_WIDTH-1:0] G;
	assign carry[0] = 0;
	assign cout = carry[WORD_WIDTH/16];
	genvar i;
	generate 
		for (i = 0; i < (WORD_WIDTH/16); i = i + 1) begin: CSA_32x16
				p_and_g_16
					i_p_and_g_16_CSA(
						.A(a[16*i+15:16*i]),
						.B(b[16*i+15:16*i]),
						.P(P[16*i+15:16*i]),
						.G(G[16*i+15:16*i]));
				cp_16
					i_cp_16_0_CSA(
						.P(P[16*i+15:16*i]),
						.G(G[16*i+15:16*i]),
						.Cin(1'b0),
						.Cout(c0[i]),
						.Sum(s0[16*i+15:16*i]));
				cp_16
					i_cp_16_1_CSA(
						.P(P[16*i+15:16*i]),
						.G(G[16*i+15:16*i]),
						.Cin(1'b1),
						.Cout(c1[i]),
						.Sum(s1[16*i+15:16*i]));
				
			assign carry [i+1] = carry[i] ? c1[i] : c0[i];	
			assign sum [16*i+15:16*i] = carry[i] ? s1[16*i+15:16*i]:s0[16*i+15:16*i];
				
		end
	endgenerate

`elsif CSA_32x32
	wire [(WORD_WIDTH/32):0] carry;
	wire [(WORD_WIDTH/32)-1:0] c0, c1;
	wire [WORD_WIDTH-1:0] s0, s1;
	wire [WORD_WIDTH-1:0] P;
	wire [WORD_WIDTH-1:0] G;
	assign carry[0] = 0;
	assign cout = carry[WORD_WIDTH/32];
	genvar i;
	generate 
		for (i = 0; i < (WORD_WIDTH/32); i = i + 1) begin: CSA_32x32
				p_and_g_32
					i_p_and_g_32_CSA(
						.A(a[32*i+31:32*i]),
						.B(b[32*i+31:32*i]),
						.P(P[32*i+31:32*i]),
						.G(G[32*i+31:32*i]));
				cp_32
					i_cp_32_0_CSA(
						.P(P[32*i+31:32*i]),
						.G(G[32*i+31:32*i]),
						.Cin(1'b0),
						.Cout(c0[i]),
						.Sum(s0[32*i+31:32*i]));
				cp_32
					i_cp_32_1_CSA(
						.P(P[32*i+31:32*i]),
						.G(G[32*i+31:32*i]),
						.Cin(1'b1),
						.Cout(c1[i]),
						.Sum(s1[32*i+31:32*i]));
				
			assign carry [i+1] = carry[i] ? c1[i] : c0[i];	
			assign sum [32*i+31:32*i] = carry[i] ? s1[32*i+31:32*i]:s0[32*i+31:32*i];
				
		end
	endgenerate
`else
	assign {carry, sum} = a + b;
`endif	
endmodule