`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:25:27 10/16/2019
// Design Name:   MIPS_Connect
// Module Name:   D:/Aanshi/AANSHI PATWARI-2019/Semester 3/Processor_Modules/MIPS_connect_tb.v
// Project Name:  Processor_Modules
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MIPS_Connect
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MIPS_connect_tb;

	// Inputs
	reg [15:0] data_in;
	reg clk;
	reg interrupt;
	reg reset;

	// Outputs
	wire [15:0] data_out;
	wire [31:0] ins;
	wire [15:0] A;
	wire [15:0] B;
	wire [15:0] Current_Address;
	wire stall;
	wire stall_pm;
	wire [15:0] ans_ex;
	wire [15:0] ans_dm;
	wire [15:0] ans_wb;
	wire [1:0] mux_sel_A;
	wire [1:0] mux_sel_B;
	wire imm_sel;

	// Instantiate the Unit Under Test (UUT)
	MIPS_Connect uut (
		.data_out(data_out), 
		.ins(ins), 
		.A(A), 
		.B(B), 
		.Current_Address(Current_Address), 
		.stall(stall), 
		.stall_pm(stall_pm), 
		.ans_ex(ans_ex), 
		.ans_dm(ans_dm), 
		.ans_wb(ans_wb), 
		.mux_sel_A(mux_sel_A), 
		.mux_sel_B(mux_sel_B), 
		.imm_sel(imm_sel), 
		.data_in(data_in), 
		.clk(clk), 
		.interrupt(interrupt), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		data_in = 0;
		clk = 0;
		interrupt = 0;
		reset = 1;

   #200;	reset = 0;
	#500;	reset = 1;
	
	end
	always begin
	#500;clk = ~clk;
	end
      
endmodule

