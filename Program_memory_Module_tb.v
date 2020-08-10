`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:02:14 08/30/2019
// Design Name:   Program_memory_Module
// Module Name:   D:/Aanshi/AANSHI PATWARI-2019/Semester 3/Processor_Modules/Program_memory_Module_tb.v
// Project Name:  Processor_Modules
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Program_memory_Module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Program_memory_Module_tb;

	// Inputs
	reg [15:0] jmp_loc;
	reg pc_mux_sel;
	reg stall;
	reg stall_pm;
	reg reset;
	reg clk;

	// Outputs
	wire [31:0] ins;
	wire [15:0] current_address;

	// Instantiate the Unit Under Test (UUT)
	Program_memory_Module uut (
		.ins(ins), 
		.current_address(current_address), 
		.jmp_loc(jmp_loc), 
		.pc_mux_sel(pc_mux_sel), 
		.stall(stall), 
		.stall_pm(stall_pm), 
		.reset(reset), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
      jmp_loc = 4'h 00008;
		pc_mux_sel = 1;
		stall = 0;
		stall_pm = 0;
		reset = 1;
		clk = 0;
		// Wait 100 ns for global reset to finish
		#2;
		reset = 0;
		
		#6;
		reset =1;
		
		#2;
		pc_mux_sel = 0;
		
		#30;
		stall=1;
		
		#10;
		stall_pm=1;
		stall=0;
		
		#10;
		pc_mux_sel=1;
		stall_pm=0;
		
		// Add stimulus here

	end
	always begin
	#5 clk = ~clk;
	end
      
endmodule

