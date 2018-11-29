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
	input ifkeep,
    input [15:0] pc_in,
    input [15:0] instr_in,
    output reg [15:0] pc_out,
    output reg [15:0] instr_out
    );

always @ (negedge clk) begin
	if (ifkeep !== 1) begin
	pc_out <= pc_in + 4;
	instr_out <= instr_in;
	end
	else begin
	pc_out <= 0;
	instr_out <= 16'b0000100000000000;
	end
end

endmodule
