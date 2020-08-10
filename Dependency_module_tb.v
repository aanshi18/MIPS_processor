`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:22:11 10/15/2019
// Design Name:   dependency_Module
// Module Name:   D:/Aanshi/AANSHI PATWARI-2019/Semester 3/Processor_Modules/Dependency_module_tb.v
// Project Name:  Processor_Modules
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: dependency_Module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Dependency_module_tb;

	// Inputs
	reg [31:0] ins;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] imm;
	wire [5:0] op_dec;
	wire [4:0] RW_dm;
	wire [1:0] mux_sel_A;
	wire [1:0] mux_sel_B;
	wire imm_sel;
	wire mem_en_ex;
	wire mem_rw_ex;
	wire mem_mux_sel_dm;

	// Instantiate the Unit Under Test (UUT)
	dependency_Module uut (
		.ins(ins), 
		.clk(clk), 
		.reset(reset), 
		.imm(imm), 
		.op_dec(op_dec), 
		.RW_dm(RW_dm), 
		.mux_sel_A(mux_sel_A), 
		.mux_sel_B(mux_sel_B), 
		.imm_sel(imm_sel), 
		.mem_en_ex(mem_en_ex), 
		.mem_rw_ex(mem_rw_ex), 
		.mem_mux_sel_dm(mem_mux_sel_dm)
	);

	initial begin
		// Initialize Inputs
		ins = 32'b0;
		clk = 0;
   	reset = 0;
		#7;
		reset = 1;
	   #3;
	   ins = 32'b000000_00001_00010_00011_00000000000;
		#10;
      ins = 32'b010100_00100_00001_00000_00000000000;
		#20;
		ins = 32'b000100_00101_00001_00100_00000000000;
		#10;
		ins = 32'b001101_00110_00001_00000_00000000101;
	end
   
	always begin
	#5 clk = ~clk;
   end
      
endmodule

