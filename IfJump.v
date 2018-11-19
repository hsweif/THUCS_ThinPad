`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:19:36 11/19/2018 
// Design Name: 
// Module Name:    IfJump 
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
module IfJump(
    input [15:0] instr,
    output reg ifJump
    );
	
	always @(*) begin
		if(instr[15:11] = 5'b00010 || instr[15:11] = 5'b00100 || instr[15:11] = 5'b00101 || instr[15:11] = 5'b01100 || (instr[15:11] = 5'b11101 && instr[7:0] = 5'b00000000))
			ifJump = 0;
		else
			ifJump = 1;
	end

endmodule
