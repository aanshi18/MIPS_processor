`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:11:36 09/19/2019
// Design Name:   Jump_Control_Module
// Module Name:   D:/Aanshi/AANSHI PATWARI-2019/Semester 3/Processor_Modules/Jump_Control_Module_tb.v
// Project Name:  Processor_Modules
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Jump_Control_Module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Jump_Control_Module_tb;

	// Inputs
	reg [15:0] jmp_address_pm;
	reg [15:0] current_address;
	reg [5:0] op_dec;
	reg [1:0] flag_ex;
	reg interrupt;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] jmp_loc;
	wire pc_mux_sel;

	// Instantiate the Unit Under Test (UUT)
	Jump_Control_Module uut (
		.jmp_loc(jmp_loc), 
		.pc_mux_sel(pc_mux_sel), 
		.jmp_address_pm(jmp_address_pm), 
		.current_address(current_address), 
		.op_dec(op_dec), 
		.flag_ex(flag_ex), 
		.interrupt(interrupt), 
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		jmp_address_pm = 16'b0000000000000111;
		current_address = 16'b0000000000000001;
		op_dec = 6'b0;
		flag_ex = 2'b11;
		interrupt = 1;
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#3;
		reset = 0;
		
		#5;
		reset = 1;
		
		#12;
		op_dec = 6'b0;
		interrupt = 0;
		
		#10;
		op_dec = 6'b001010;
		
		#20;
		op_dec = 6'b001101;
		flag_ex = 2'b00;
		
		#10;
		op_dec = 6'b0;
		
		#10;
		op_dec = 6'b010111;
		
		#10;
		op_dec = 6'b010001;
		/*#8;
		interrupt = 1;
		
		#10;
		interrupt = 0;
		jmp_address_pm = 16'b0000000000001000;
		
		#10;
		op_dec = 6'b011000;
		
		#20;
		op_dec = 6'b010000;
		flag_ex = 2'b0;
		
		#10;
		op_dec = 6'b011110;*/
		
		
        
		// Add stimulus here

	end
	always begin
	#5 clk = ~clk;
	end
      
endmodule

