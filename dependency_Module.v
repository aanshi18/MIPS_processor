`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:21:23 10/10/2019 
// Design Name: 
// Module Name:    dependency_Module 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module dependency_Module(imm,op_dec,RW_dm,mux_sel_A,mux_sel_B,imm_sel,mem_en_ex,mem_rw_ex,mem_mux_sel_dm,ins,clk,reset);
input [31:0] ins;
input clk,reset;
output reg [15:0] imm;
output reg [5:0] op_dec;
output [4:0] RW_dm;
output [1:0] mux_sel_A,mux_sel_B;
output reg imm_sel,mem_en_ex,mem_rw_ex,mem_mux_sel_dm;

wire JMP,Cond_J,LD_fb,Imm,ld,ST;
wire Load_fb_flip_tmp;
wire Load_and,Load_flip_tmp;
wire ST_flip_tmp;
wire ins_flip_tmp;
wire imm_sel_tmp;
wire ld_ST_or,imm_and;
wire mem_rw_ex_tmp,mem_mux_sel_dm_tmp,mem_mux_sel_dm_prv_tmp,mem_en_ex_tmp;
wire [14:0] nor_extend, extend_and;
wire [5:0] op_dec_tmp;
wire [15:0] imm_tmp;
//wire [4:0] delay1_tmp, delay2_tmp, delay3_tmp, prv1_tmp, prv2_tmp, prv3_tmp;
wire cmp_a1, cmp_a2, cmp_a3, cmp_b1, cmp_b2, cmp_b3;
wire and_a1, and_a2, and_b1, and_b2;

reg [4:0] delay1, delay2, delay3, prv1, prv2, prv3;
reg Load_fb_flip, Load_flip, ST_flip, ins_flip, mem_mux_sel_dm_prv;

assign JMP=(~ins[26] & ~ins[27] & ~ins[28]& ins[29] & ins[30] & ~ins[31] );
assign Cond_J=(ins[28]& ins[29] & ins[30] & ~ins[31] );
assign LD_fb=(~ins[26] & ~ins[27] & ins[28]& ~ins[29] & ins[30] & ~ins[31] & ~Load_fb_flip);
assign Imm=( ins[29] & ~ins[30] & ~ins[31] );
assign ld=(~ins[26] & ~ins[27] & ins[28]& ~ins[29] & ins[30] & ~ins[31] );
assign ST=(ins[26] & ~ins[27] & ins[28]& ~ins[29] & ins[30] & ~ins[31] );

assign Load_fb_flip_tmp = (reset) ? LD_fb: 1'b0;
assign Load_and=(ld & ~Load_flip);
assign Load_flip_tmp= (reset) ? Load_and: 1'b0;
assign ST_flip_tmp=(reset)? ST:1'b0;
assign ins_flip_tmp=(reset)?ins[26]:1'b0;
assign imm_sel_tmp=(reset) ? Imm:1'b0;
assign ld_ST_or=(ST_flip | Load_flip);
assign imm_and=(ld_ST_or & ~ins_flip);
assign mem_rw_ex_tmp=(reset)?ins_flip:1'b0;
assign mem_mux_sel_dm_prv_tmp=(reset)?imm_and:1'b0;
assign mem_mux_sel_dm_tmp=(reset)?mem_mux_sel_dm_prv:1'b0;
assign mem_en_ex_tmp=(reset)?ld_ST_or:1'b0;

assign nor_extend = {15{~(JMP | Cond_J | Load_fb_flip)}};
assign extend_and = nor_extend & ins[25:11];
assign op_dec_tmp = (reset) ? ins[31:26] : 6'b0;

assign cmp_a1 = (delay1 == prv1) ? 1'b1 : 1'b0;
assign cmp_a2 = (delay1 == prv2) ? 1'b1 : 1'b0;
assign cmp_a3 = (delay1 == prv3) ? 1'b1 : 1'b0;

assign cmp_b1 = (delay3 == prv1) ? 1'b1 : 1'b0;
assign cmp_b2 = (delay3 == prv2) ? 1'b1 : 1'b0;
assign cmp_b3 = (delay3 == prv3) ? 1'b1 : 1'b0;

assign and_a1 = ~(cmp_a1) & cmp_a2;
assign and_a2 = ~(cmp_a1) & ~(cmp_a2) & cmp_a3;

assign and_b1 = ~(cmp_b1) & cmp_b2;
assign and_b2 = ~(cmp_b1) & ~(cmp_b2) & cmp_b3;

assign mux_sel_A = (cmp_a1) ? 2'b01 : 
						 ((and_a1) ? 2'b10 :
						 ((and_a2) ? 2'b11 : 2'b00));
assign mux_sel_B = (cmp_b1) ? 2'b01 : 
						 ((and_b1) ? 2'b10 :
						 ((and_b2) ? 2'b11 : 2'b00));

assign RW_dm = prv2;
always @ (posedge clk)
begin
Load_fb_flip<=Load_fb_flip_tmp;
Load_flip<=Load_flip_tmp;
ST_flip<=ST_flip_tmp;
ins_flip<=ins_flip_tmp;
imm_sel<=imm_sel_tmp;
mem_rw_ex<=mem_rw_ex_tmp;
mem_mux_sel_dm_prv<=mem_mux_sel_dm_prv_tmp;
mem_mux_sel_dm<=mem_mux_sel_dm_tmp;
mem_en_ex<=mem_en_ex_tmp;
op_dec <= op_dec_tmp;
imm <= (reset) ? ins[15:0] : 16'b0;
delay1 <= (reset) ? extend_and[9:5] : 5'b0;
delay2 <= (reset) ? extend_and[14:10] : 5'b0;
delay3 <= (reset) ? extend_and[4:0] : 5'b0;
prv1 <= (reset) ? delay2 : 5'b0;
prv2 <= (reset) ? prv1 : 5'b0;
prv3 <= (reset) ? prv2 : 5'b0;
 
end

    


endmodule
