`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:44:42 10/10/2019 
// Design Name: 
// Module Name:    data_memory_Module 
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
module data_memory_Module(ans_dm,ans_ex, DM_data,mem_rw_ex,mem_en_ex,mem_mux_sel_dm,reset,clk);

output [15:0] ans_dm;
input [15:0] ans_ex, DM_data;
input mem_rw_ex,mem_en_ex,mem_mux_sel_dm,reset,clk;

wire [15:0] DM_out,Ex_out_temp;
reg [15:0]  Ex_out;

//assign Ex_out_temp=(reset)?ans_ex:16'b0;
    
dm_memory your_instance_name (
  .clka(clk), // input clka
  .ena(mem_en_ex), // input ena
  .wea(mem_rw_ex), // input [0 : 0] wea
  .addra(ans_ex), // input [15 : 0] addra
  .dina(DM_data), // input [15 : 0] dina
  .douta(DM_out) // output [15 : 0] douta
);

always @(posedge clk)
begin
   Ex_out<=(reset)?ans_ex:16'b0;
end

assign ans_dm=(mem_mux_sel_dm)?DM_out:Ex_out;

endmodule
