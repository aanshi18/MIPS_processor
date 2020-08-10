`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:21:10 08/31/2019
// Design Name:   ALU_Module
// Module Name:   D:/Aanshi/AANSHI PATWARI-2019/Semester 3/Processor_Modules/ALU_Module_tb.v
// Project Name:  Processor_Modules
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU_Module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_Module_tb;

	// Inputs
	reg [5:0] op_dec;
	reg [15:0] A;
	reg [15:0] B;
	reg [15:0] data_in;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] ans_ex;
	wire [1:0] flag_ex;
	wire [15:0] data_out;
	wire [15:0] DM_data;

	// Instantiate the Unit Under Test (UUT)
	ALU_Module uut (
		.op_dec(op_dec), 
		.A(A), 
		.B(B), 
		.data_in(data_in), 
		.clk(clk), 
		.reset(reset), 
		.ans_ex(ans_ex), 
		.flag_ex(flag_ex), 
		.data_out(data_out), 
		.DM_data(DM_data)
	);
integer i=0;
	initial begin
		// Initialize Inputs
		op_dec = 0;
		A = 16'b0000000000000100;  // 4000H
      B = 16'b0000000000000100;  //c000H
		data_in = 16'b0000000000001000; //0008H
		clk = 0;
		reset = 1'b1;
		#2;
		reset=1'b0;
		#8;
		reset=1'b1;		
		// Wait 100 ns for global reset to finish
		

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
		
		
		
		/*for(i = 0 ; i<=24;i =i+1)
			begin
				if(i != 3 && i!= 11 && i != 18 && i!=19)  
				begin
					 op_dec = i[5:0] ;
							A = 16'b0100000000000000;  // 4000H
							B = 16'b1100000000000000;  //c000H
							data_in = 16'b0000000000001000; //0008H
					#10;		
				end
			end
		for( i = 25 ; i<=31 ; i=i+1)
			begin
					 op_dec = i[5:0] ; 
					A = 16'b1100000000000000;  //c000H
					B = 16'b0000000000000001;  //0001H
					data_in = 16'b0000000000001000; //0008H
					#10;
			end*/
			
		// Add stimulus here

	end
	
	always begin
	#5 clk = ~clk;
   end
      
endmodule

