`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:20:41 10/10/2019 
// Design Name: 
// Module Name:    write_back_Module 
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
module write_back_Module(ans_wb,ans_dm,reset,clk);


input [15:0] ans_dm;
input reset, clk;

//reg [15:0] ans_wb_temp;
output reg[15:0] ans_wb;

//assign ans_wb=(reset)?ans_wb_temp:16'b0;

always @(posedge clk)
begin	
	ans_wb=(reset)?ans_dm:16'b0;
end

   


endmodule
