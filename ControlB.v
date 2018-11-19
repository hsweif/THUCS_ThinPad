`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:21:49 11/19/2018 
// Design Name: 
// Module Name:    ControlB 
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
module ControlB(
    input [15:0] instr,
    output reg[1:0] controlB
    );
	
	always @(*) begin
		if((instr[15:11] == 5'b11100 && (instr[1:0] == 2'b01 || instr[1:0] == 2'b11)) || (instr[15:11] == 5'b11101 && (instr[4:0] == 5'b01100 || instr[4:0] == 5'b01010 || instr[4:0] == 5'b01011 || instr[4:0] == 5'b01101 || instr[4:0] == 5'b00010)) || (instr[15:11] == 5'b01111 && instr[4:0] == 5'b00000))
			controlB = 2'b00; //ry
		else if((instr[15:11] = 5'b00110 && (instr[1:0] = 2'b00 || instr[1:0] = 2'b11)) || instr[15:11] = 5'b01000 || instr[15:11] = 5'b01001 || instr[15:11] = 5'b01011 || instr[15:8] = 8'b01100011 || instr[15:11] = 5'b01101 || instr[15:11] = 5'b10010 || instr[15:11] = 5'b10011 || instr[15:11] = 5'b11010 || instr[15:11] = 5'b11011)
			controlB = 2'b01; //imm
		else
			controlB = 2'b10; // default value, 0
	end

endmodule
