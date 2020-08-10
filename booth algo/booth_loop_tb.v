`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:30:39 12/13/2019
// Design Name:   booth_loop
// Module Name:   D:/Aanshi/AANSHI PATWARI-2019/Semester 3/booth_algorithm/booth_loop_tb.v
// Project Name:  booth_algorithm
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: booth_loop
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module booth_loop_tb;

	// Inputs
	reg [7:0] M;
	reg [7:0] Q;

	// Outputs
	wire [15:0] Z;

	// Instantiate the Unit Under Test (UUT)
	booth_loop uut (
		.M(M), 
		.Q(Q), 
		.Z(Z)
	);

	initial begin
		// Initialize Inputs
		M = 0;
		Q = 0;

		// Wait 100 ns for global reset to finish
		#50;
		M = 4;
		Q = 2;
		
		#50;
		M = -50;
		Q = 50;
		
		#50;
		M = 30;
		Q = -60;
		
		#50;
		M = -5;
		Q = 2;
        
		// Add stimulus here

	end
      
endmodule

