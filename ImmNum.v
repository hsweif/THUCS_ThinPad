`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:54:40 11/19/2018 
// Design Name: 
// Module Name:    ImmNum 
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
module ImmNum(
    input [15:0] instr,
    output reg[15:0] immNum
    );
	 
	always @(*) begin 
		if(instr[15:11] == 5'b01001 || instr[15:8] == 8'b01100011 || instr[15:11] == 5'b00100 || instr[15:11] == 5'b00101 || instr[15:8] == 8'b01100000 || instr[15:11] == 5'b10010 || instr[15:11] == 5'b11010)
			immNum = { {8{instr[7]}}, instr[7:0]};
		else if(instr[15:11] == 5'b01000 && instr[4] == 0)
			immNum = { {12{instr[3]}}, instr[3:0]};
		else if(instr[15:11] == 5'b00010)
			immNum = { {5{instr[10]}}, instr[10:0]};
		else if(instr[15:11] == 5'b10011 || instr[15:11] == 5'b11011)
			immNum = { {11{instr[4]}}, instr[4:0]};
		else if(instr[15:11] == 5'b00110)
			immNum = { {13{instr[4]}}, instr[4:2]};
		else if(instr[15:11] == 5'b01101 || instr[15:11] == 5'b01011)
			immNum = { 8'b00000000, instr[7:0]};
		else
			immNum = 0;
	end

endmodule
