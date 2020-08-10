`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:06:14 09/12/2019 
// Design Name: 
// Module Name:    Stall_control_module 
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
module Stall_control_module(stall, stall_pm, op_dec, clk, reset);
//defining the outputs
output stall;
output stall_pm;
//defining the inputs
input clk,reset;
input [5:0] op_dec;
//defining the wires for the outputs of the and gates
wire hlt,ld,jump;
//defining the ouputs of D-flipflop_dec
reg q1,q2,q3,q4;
//assigning the value for halt op_deceration
assign hlt = op_dec[0] & ~op_dec[1] & ~op_dec[2] & ~op_dec[3] & op_dec[4] & ~op_dec[5];
//assigning the value for load op_deceration
assign ld = ~op_dec[0] & ~op_dec[1] & op_dec[2] & ~op_dec[3] & op_dec[4] & ~op_dec[5] & ~q1 ; 
//assigning value for jump op_deceration
assign jump = op_dec[2] & op_dec[3] & op_dec[4] & ~op_dec[5] & ~q4;
//defining stall 
assign stall = hlt | ld | jump;

always @(posedge clk)
begin
   // assigning the values for flipflop_decs
	q1 <= (reset) ? ld : 1'b0;
	q2 <= (reset) ?  jump : 1'b0;
	q3 <= (reset) ? stall : 1'b0;
	q4 <= (reset) ? q2 : 1'b0;
end
//assigning the value of q3 to stall_pm
assign stall_pm = q3;
endmodule
