`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:08:37 11/25/2018 
// Design Name: 
// Module Name:    mem_wb 
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
module mem_wb(
    input clk,
	 input rst,
    input controlwb_in,
    input [15:0] memdata_in,
    input [15:0] alu_in,
	 input [3:0] wreg_in,
    output reg controlwb_out,
    output reg [15:0] memdata_out,
    output reg [15:0] alu_out,
    output reg [3:0] wreg_out
    );

always @ (negedge rst or negedge clk) begin
if (rst == 0) begin
	wreg_out <= 4'b1111;
end
else begin 
	controlwb_out <= controlwb_in;
	memdata_out <= memdata_in;
	alu_out <= alu_in;
	wreg_out <= wreg_in;
	end
end

endmodule
