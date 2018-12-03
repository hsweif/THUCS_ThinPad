`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:21:54 11/25/2018 
// Design Name: 
// Module Name:    if_id 
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
module if_id(
	input clk,
	input rst,
	input ifkeep,
	input ifClear,
    input [15:0] pc_in,
    input [15:0] instr_in,
    output reg [15:0] pc_out,
    output reg [15:0] instr_out
    );
always @ (negedge rst or negedge clk) begin
	
	if (rst == 0) begin
		instr_out <= 16'b0000100000000000;
		pc_out <= 0;
	end
	else if(ifkeep == 1) begin
	end
	else if(ifClear == 1) begin //else if(ifClear === 1) begin
		pc_out <= 0;
		instr_out <= 16'b0000100000000000;
	end
	else begin
	pc_out <= pc_in + 1;
	instr_out <= instr_in;
	end
end
endmodule
