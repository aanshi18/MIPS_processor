`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:48:51 10/10/2019 
// Design Name: 
// Module Name:    MIPS_Connect 
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
module MIPS_Connect(data_out,data_in,clk,interrupt,reset);

input [15:0] data_in;
input clk,interrupt,reset;

output [15:0] data_out;
output [15:0] A,B,Current_Address,ans_ex,ans_dm,ans_wb;
output [31:0] ins;
output [1:0] mux_sel_A,mux_sel_B;
output imm_sel;

wire [15:0] jmp_address_pm;
wire [5:0] op_dec;//opcode
wire [1:0] flag_ex;
wire stall,stall_pm;
wire [15:0] jmp_loc;
wire pc_mux_sel;
wire [15:0] imm;
wire [4:0] RW_dm;
wire mem_en_ex,mem_rw_ex,mem_mux_sel_dm;
wire [4:0] RA,RB;
wire [15:0] DM_data;

assign jmp_address_pm = ins[15:0];
assign RB = ins[15:11];
assign RA = ins[20:16];
//assign op_dec=ins[31:26];

//Program_memory_Module pmm(ins,Current_Address,jmp_loc,pc_mux_sel,stall,stall_pm,reset,clk);//output-ins,current_addres
Program_memory_Module_change pmm(ins,Current_Address,jmp_loc,pc_mux_sel,stall,stall_pm,reset,clk);//output-ins,current_address
Jump_Control_Module jcm(jmp_loc,pc_mux_sel,jmp_address_pm,Current_Address,ins[31:26],flag_ex,interrupt,clk,reset);// output- pc_mux_sel , jmp_loc 
Stall_control_module scm(stall, stall_pm, ins[31:26], clk, reset);//output-stall,stall_pm,input
Register_Bank_Module rbm(A, B, ans_ex, ans_dm, ans_wb, imm, RA, RB, RW_dm, mux_sel_A, mux_sel_B, imm_sel, clk);//ouput-A,B,input
dependency_Module dm(imm,op_dec,RW_dm,mux_sel_A,mux_sel_B,imm_sel,mem_en_ex,mem_rw_ex,mem_mux_sel_dm,ins,clk,reset);//input - ins
ALU_Module alu(ans_ex ,  flag_ex , data_out , DM_data ,op_dec , A , B , data_in , clk , reset);//input,output- ans_ex
data_memory_Module dmm(ans_dm,ans_ex, DM_data,mem_rw_ex,mem_en_ex,mem_mux_sel_dm,reset,clk);//output-ans_dm
write_back_Module wbm(ans_wb,ans_dm,reset,clk);//ouput - ans_wb


endmodule
