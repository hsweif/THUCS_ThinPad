`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:03:17 11/19/2018 
// Design Name: 
// Module Name:    ReadReg1 
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
module ReadReg1(
    input [15:0] instr,
    output reg[3:0] readReg
    );

	always @(*) begin
		if(instr[15:8] == 8'b01100011)										readReg = 4'b1000;//SP
		else if(instr[15:11] == 5'b10010)									readReg = 4'b1000;//SP
		else if(instr[15:8] == 8'b01100000)									readReg = 4'b1001;//T
		else if(instr[15:11] == 5'b11110 && instr[4:0] == 0) 			readReg = 4'b1010;//IH
		else if(instr[15:8] == 8'b01100100) 								readReg = {0, instr[7:5]};
		else if(instr[15:11] == 5'b11101 && instr[4:0] == 5'b01011)	readReg = {0, instr[7:5]};
		else																			readReg = {0, instr[10:8]};
	end
	
endmodule
