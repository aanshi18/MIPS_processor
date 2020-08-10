`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:32:41 09/12/2019
// Design Name:   Stall_control_module
// Module Name:   D:/Aanshi/AANSHI PATWARI-2019/Semester 3/Processor_Modules/Stall_control_module_tb.v
// Project Name:  Processor_Modules
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Stall_control_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Stall_control_module_tb;

	// Inputs
	reg [5:0] op_dec;
	reg clk;
	reg reset;

	// Outputs
	wire stall;
	wire stall_pm;

	// Instantiate the Unit Under Test (UUT)
	Stall_control_module uut (
		.stall(stall), 
		.stall_pm(stall_pm), 
		.op_dec(op_dec), 
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		op_dec = 6'b0;
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#5;
		reset = 0;
		
		#10;
		reset = 1;
		
		#10;
		op_dec = 6'b001010;
		
		#20;
		op_dec = 6'b001101;
		
		#10;
		op_dec = 6'b0;
		
		#10;
		op_dec = 6'b010111;
		
		#10;
		op_dec = 6'b010001;
		
        
		// Add stimulus here

	end
	
	always begin
	#5 clk = ~clk; 
	end
      
endmodule

