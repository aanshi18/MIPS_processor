`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:25:17 12/13/2019 
// Design Name: 
// Module Name:    booth_loop 
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
module booth_loop(
    input [7:0] M,
    input [7:0] Q,
    output [15:0] Z
    );
wire [7:0] A_out1;
wire [8:0] Q_out1;

wire [7:0] A_out2;
wire [8:0] Q_out2;

wire [7:0] A_out3;
wire [8:0] Q_out3;

wire [7:0] A_out4;
wire [8:0] Q_out4;

wire [7:0] A_out5;
wire [8:0] Q_out5;

wire [7:0] A_out6;
wire [8:0] Q_out6;

wire [7:0] A_out7;
wire [8:0] Q_out7;

wire [7:0] A_out8;
wire [8:0] Q_out8;



booth booth1(
		.A_in(8'b0),
		.M(M),
		.Q_in({Q,1'b0}),
		.A_out(A_out1),
		.Q_out(Q_out1)
);
booth booth2(
		.A_in(A_out1),
		.M(M),
		.Q_in(Q_out1),
		.A_out(A_out2),
		.Q_out(Q_out2)
);
booth booth3(
		.A_in(A_out2),
		.M(M),
		.Q_in(Q_out2),
		.A_out(A_out3),
		.Q_out(Q_out3)
);
booth booth4(
		.A_in(A_out3),
		.M(M),
		.Q_in(Q_out3),
		.A_out(A_out4),
		.Q_out(Q_out4)
);
booth booth5(
		.A_in(A_out4),
		.M(M),
		.Q_in(Q_out4),
		.A_out(A_out5),
		.Q_out(Q_out5)
);
booth booth6(
		.A_in(A_out5),
		.M(M),
		.Q_in(Q_out5),
		.A_out(A_out6),
		.Q_out(Q_out6)
);
booth booth7(
		.A_in(A_out6),
		.M(M),
		.Q_in(Q_out6),
		.A_out(A_out7),
		.Q_out(Q_out7)
);
booth booth8(
		.A_in(A_out7),
		.M(M),
		.Q_in(Q_out7),
		.A_out(A_out8),
		.Q_out(Q_out8)
);

assign Z={A_out8,Q_out8[8:1]};


endmodule
