`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:24:57 12/13/2019 
// Design Name: 
// Module Name:    booth 
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
module booth(
   input [7:0] A_in,
    input [7:0] M,
    input [8:0] Q_in,
    output [7:0] A_out,
	 output [8:0] Q_out
    );
	 
reg [7:0] A_temp;
reg [8:0] Q_temp;

wire [7:0] A_sum=A_in+M;
wire [8:0] A_sub=A_in-M;

always@(A_in,M,Q_in,A_sum,A_sub)
begin

	case(Q_in[1:0])
	2'b00,2'b11: begin
				    A_temp<={A_in[7],A_in[7:1]};
					 Q_temp<={A_in[0],Q_in[8:1]};

					end
	2'b01: begin
				    A_temp<={A_sum[7],A_sum[7:1]};
					 Q_temp<={A_sum[0],Q_in[8:1]};

					end
					
	2'b10: begin
				    A_temp<={A_sub[7],A_sub[7:1]};
					 Q_temp<={A_sub[0],Q_in[8:1]};

					end
	endcase
end
assign A_out=A_temp;
assign Q_out=Q_temp;



endmodule
