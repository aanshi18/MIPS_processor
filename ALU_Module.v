`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:50:11 08/29/2019 
// Design Name: 
// Module Name:    ALU_Module 
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
module ALU_Module(  ans_ex ,  flag_ex , data_out , DM_data ,op_dec , A , B , data_in , clk , reset );
input [15:0] A ,B , data_in ;
input clk , reset;
input [5:0] op_dec;
output reg [15:0] ans_ex , data_out , DM_data ;
output wire [1:0] flag_ex ;


wire [15:0] ans_temp , data_out_buff;
wire [15:0] ADD , RSA;
wire [15:0] overflowAdd;
reg [1:0] flag_prv;
wire carry1 , carry2 , overflow_Flag , zero_flag;
wire [15:0] x;

wire [15:0] ans_temp_t,data_out_temp,DM_data_temp;//For reset condition, it will store values temporary
wire [1:0]flag_prv_temp;

assign data_out_buff = (op_dec == 6'b010111) ? A : data_out;
assign x = A >> B[3:0];

assign RSA =   A[15]  == 1'b0    ?  x :
					B[3:0] == 4'b0000 ?  x :								//0 bit RSA
					B[3:0] == 4'b0001 ?  { 1'b1 , x[14:0] } :			//1 bit RSA
					B[3:0] == 4'b0010 ?  { 2'b1 , x[13:0] } :			//2 bit RSA
					B[3:0] == 4'b0011 ?  { 3'b1 , x[12:0] } :			//3 bit RSA
					B[3:0] == 4'b0100 ?  { 4'b1 , x[11:0] } :			//4 bit RSA
					B[3:0] == 4'b0101 ?  { 5'b1 , x[10:0] } :			//5 bit RSA
					B[3:0] == 4'b0110 ?  { 6'b1 , x[9:0] } :			//6 bit RSA
					B[3:0] == 4'b0111 ?  { 7'b1 , x[8:0] } :			//7 bit RSA
					B[3:0] == 4'b1000 ?  { 8'b1 , x[7:0] } :			//8 bit RSA
					B[3:0] == 4'b1001 ?  { 9'b1 , x[6:0] } :			//9 bit RSA
					B[3:0] == 4'b1010 ?  { 10'b1 , x[5:0] } :			//10 bit RSA
					B[3:0] == 4'b1011 ?  { 11'b1 , x[4:0] } :			//11 bit RSA
					B[3:0] == 4'b1100 ?  { 12'b1 , x[3:0] } :			//12 bit RSA
					B[3:0] == 4'b1101 ?  { 13'b1 , x[2:0] } :			//13 bit RSA
					B[3:0] == 4'b1110 ?  { 14'b1 , x[1:0] } :			//14 bit RSA
					B[3:0] == 4'b1111 ?  { 15'b1 , x[0] } : 16'bx;  //15 bit RSA

assign {carry1 , ADD} = A+ (B ^ {16{op_dec[0]}}) + op_dec[0];//Addtion of two unsigned numbers
//assign overflowAdd = 16'b0;
assign  overflowAdd = A[14:0] + B[14:0];//Addtion of two signed numbers
assign carry2  = overflowAdd[15];
assign overflow_Flag = carry1 ^ carry2;

assign ans_temp = (op_dec == 6'b000000 ) ? ADD :			//1
						(op_dec == 6'b000001) ? ADD :			//2
						(op_dec == 6'b000010) ? B:				//3
						(op_dec == 6'b000100) ? A&B:			//4
						(op_dec == 6'b000101) ? A|B:			//5	
						(op_dec == 6'b000110) ? A^B:			//6
						(op_dec == 6'b000111) ? (~B):			//7
						(op_dec == 6'b001000) ? ADD:			//8
						(op_dec == 6'b001001) ? ADD:			//9
						(op_dec == 6'b001010) ? B:				//10
						(op_dec == 6'b001100) ? A & B :		//11
						(op_dec == 6'b001101) ? A | B :		//12
						(op_dec == 6'b001110) ? A  ^ B :		//13
						(op_dec == 6'b001111) ? (~B):			//14
						(op_dec == 6'b010000) ? ans_ex:		//15
						(op_dec == 6'b010001) ? ans_ex :		//16
						(op_dec == 6'b010100) ? A :			//17
						(op_dec == 6'b010101) ? A :			//18
						(op_dec == 6'b010110) ? data_in :	//19	
						(op_dec == 6'b010111) ? ans_ex :		//20
						(op_dec == 6'b011000) ? ans_ex :		//21
						(op_dec == 6'b011001) ? A<<B[3:0]:  //22
						(op_dec == 6'b011010) ? A>>B[3:0]:  //23
						(op_dec == 6'b011011) ? RSA :			//24
						(op_dec == 6'b011100) ? ans_ex :		//25
						(op_dec == 6'b011101) ? ans_ex :		//26
						(op_dec == 6'b011110) ? ans_ex :		//27
						(op_dec == 6'b011111) ? ans_ex  : 16'b0;		//28
						
assign zero_flag  = (ans_temp == 16'b0)? 1'b1 : 1'b0;
				
assign flag_ex[0] =( (op_dec == 6'b000000) || (op_dec == 6'b000001) || (op_dec == 6'b001000) || (op_dec == 6'b001001) )? overflow_Flag :	//1,2,8,9							
					          ((op_dec == 6'b011100)  || (op_dec == 6'b011101) || (op_dec == 6'b011110) || (op_dec == 6'b011111)) ? flag_prv[0]:1'b0;	//25,26,27,28
								
assign flag_ex[1]  =  ((op_dec == 6'b010000) || 	(op_dec == 6'b010001) || (op_dec == 6'b010100) || (op_dec == 6'b010101) || (op_dec==6'b010111) || (op_dec==011000)) ? 1'b0 ://15,16,17,18,20,21
							 ((op_dec == 6'b011100)  || (op_dec == 6'b011101) || (op_dec == 6'b011110) || (op_dec == 6'b011111)) ? flag_prv[1]: zero_flag;	//25,26,27,28
					
assign ans_temp_t=(reset)?ans_temp:16'b0;
assign data_out_temp=(reset)?data_out_buff:16'b0;
assign DM_data_temp=(reset)?B:16'b0;
assign flag_prv_temp=(reset)?flag_ex:2'b0;		
										
always@(posedge clk)
		begin				
		ans_ex   <= ans_temp_t;					
   	flag_prv <= flag_prv_temp;
		data_out <= data_out_temp;
		DM_data  <= DM_data_temp;
		end

endmodule
