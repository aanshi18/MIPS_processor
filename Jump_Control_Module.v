`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:21:29 09/19/2019 
// Design Name: 
// Module Name:    Jump_Control_Module 
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
module Jump_Control_Module(jmp_loc,pc_mux_sel,jmp_address_pm,current_address,op_dec,flag_ex,interrupt,clk,reset);
output [15:0] jmp_loc;
output pc_mux_sel;

input [15:0] jmp_address_pm,current_address;
input [5:0] op_dec;
input clk,reset,interrupt;
input [1:0] flag_ex;

wire JV,JNV,JZ,JNZ,JMP,RET;

wire current_address_tmp;//for incrementor 
reg q1,q2;//for d flip-flop_dec_dec
wire q1_tmp,q2_tmp;

wire [15: 0] mux_inc;
wire [15: 0] reg_inc_tmp;
reg [15: 0] reg_inc;

wire [1:0] mux_flg;
wire [1:0] reg_flg_tmp;
reg [1:0] reg_flg;

wire [1:0] mux_flag;

wire [15:0] mux_add;

wire [15:0] mux_ret;

wire jnz_and,jz_and;
wire jnv_and,jv_and;

assign JV = (~op_dec[0] & ~op_dec[1] & op_dec[2] & op_dec[3] & op_dec[4] & ~op_dec[5]);
assign JNV = (op_dec[0] & ~op_dec[1] & op_dec[2] & op_dec[3] & op_dec[4] & ~op_dec[5]);
assign JZ = (~op_dec[0] & op_dec[1] & op_dec[2] & op_dec[3] & op_dec[4] & ~op_dec[5]);
assign JNZ = (op_dec[0] & op_dec[1] & op_dec[2] & op_dec[3] & op_dec[4] & ~op_dec[5]);
assign JMP = (~op_dec[0] & ~op_dec[1] & ~op_dec[2] & op_dec[3] & op_dec[4] & ~op_dec[5]);
assign RET = (~op_dec[0] & ~op_dec[1] & ~op_dec[2] & ~op_dec[3] & op_dec[4] & ~op_dec[5]);

//assign current_address_tmp = (current_address + 16'h0001);
 
assign mux_inc = (interrupt) ? (current_address +1'b1) : reg_inc;

assign reg_inc_tmp = (reset) ? mux_inc : 16'b0;

assign mux_flg = (q2) ? flag_ex : reg_flg;

assign reg_flg_tmp = (reset) ? mux_flg : 2'b0;

assign mux_flag = (RET) ? reg_flg : flag_ex;

assign mux_add = (q1) ? 16'b1111000000000000 : jmp_address_pm;

assign mux_ret = (RET) ? reg_inc : mux_add;

assign jmp_loc = mux_ret;

assign jnz_and = ~mux_flag[1] & JNZ;
assign jz_and = mux_flag[1] & JZ;

assign jnv_and = ~mux_flag[0] & JNV;
assign jv_and = mux_flag[0] & JV;

assign pc_mux_sel = jv_and | jnv_and | jz_and | jnz_and | RET | JMP | q1;
assign q1_tmp = (reset) ? interrupt : 1'b0;
assign q2_tmp = (reset) ? q1 : 1'b0;
always @ (posedge clk)
begin 
q1 <= q1_tmp;
q2 <= q2_tmp ;
reg_inc <= reg_inc_tmp;
reg_flg <= reg_flg_tmp;
end

endmodule
