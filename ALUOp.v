`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:39:22 11/19/2018 
// Design Name: 
// Module Name:    ALUOp 
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
module ALUOp(
    input [15:0] instr,
    output reg[3:0] ALUOp
    );
	
	always @(*) begin
		if(instr[15:11] == 5'b00100 || instr[15:11] == 5'b00101 || instr[15:8] == 8'b01100000 || (instr[15:11] == 5'b11101 && instr[4:0] == 5'b01010) || (instr[15:11] == 5'b11100 && instr[1:0] == 2'b11) || instr[15:11] == 5'b01011)
			ALUOp = 4'b0001; //SUB
		else if(instr[15:11] == 5'b11101 && instr[4:0] == 5'b01100)
			ALUOp = 4'b0010; //AND
		else if(instr[15:11] == 5'b11101 && instr[4:0] == 5'b01011)
			ALUOp = 4'b0001; //NEG
		else if(instr[15:11] == 5'b11101 && instr[4:0] == 5'b01111)
			ALUOp = 4'b0101; //NOT
		else if(instr[15:11] == 5'b11101 && instr[4:0] == 5'b01101)
			ALUOp = 4'b0011; //OR
		else if(instr[15:11] == 5'b00110 && instr[1:0] == 2'b00)
			ALUOp = 4'b0110; //SLL
		else if(instr[15:11] == 5'b00110 && instr[1:0] == 2'b11)
			ALUOp = 4'b1000; //SRA
		else
			ALUOp = 4'b0000; //ADD, default value
	end
	
endmodule
