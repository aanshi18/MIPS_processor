`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:18:51 10/14/2019 
// Design Name: 
// Module Name:    Program_memory_Module_change 
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
module Program_memory_Module_change(ins,current_address,jmp_loc,pc_mux_sel,stall,stall_pm,reset,clk);
//the outputs 	 
output [31:0] ins;             //instruction
output [15:0] current_address; //current adddress

//the inputs 
input [15:0] jmp_loc ; // jump location
input pc_mux_sel;      //selcection line    
input stall;           //selection line
input stall_pm;        //selection line
input reset,clk;       // for register , here the reset is negative edge triggered

//wire for holding the inner outputs
wire [15:0] CAJ ;
wire [15:0] CAR ;
wire [15:0] hold_address_temp ;  // temp variable
wire [15:0] IA ;
wire [31:0] PM_out;
wire [31:0] ins_pm;
wire [31:0] ins_prv_temp;        // temp variable

//output which are reg (defined)dependent
reg [15:0] hold_address;
reg [15:0] next_address;
reg [31:0] ins_prv;

//CAJ holds the value of either the current address or the next address
assign CAJ=(stall)?hold_address:next_address;

//CAR holds the value of the jump location address or the value hold by CAJ
assign CAR=(pc_mux_sel)?jmp_loc:CAJ;

//the current address based on the rreset button holds the value of CAR or resets itself
assign current_address=(reset)?CAR:16'b0;

//IA based on the reset button button either increments the value of current address or resets the value to 0
assign IA=(reset)?(current_address+16'b1):16'b0;

//temp variable is here to hold the value of current address or reset the value to 0
assign hold_address_temp=(reset)?current_address:16'b0;

//ins_pm holds the value of the previous instruction format or of output by the program memory
assign ins_pm=(stall_pm)?ins_prv:PM_out;

//ins contains the value of either ins_pm or resets itself to 0 when reset is triggered
assign ins=(reset)?ins_pm:32'b0;

//this is the program memory where th e input is current address and output is PM_out
pmb your_instance_name (
  .clka(clk), // input clka
  .addra(current_address), // input [15 : 0] addra
  .douta(PM_out) // output [31 : 0] douta
);
always @(posedge clk) 
begin
  next_address <= IA; 
  hold_address<=hold_address_temp;
  ins_prv<=ins;
end
endmodule
