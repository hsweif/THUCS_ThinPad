`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:43:17 11/19/2018 
// Design Name: 
// Module Name:    JorB 
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
module JorB(
    input [15:0] instr,
    output reg[1:0] jorB
    );
	
	//00:B 01:J 10:B== 11:B!=
	always @(*) begin
		if(instr[15:11] == 5'b00010)
			jorB = 2'b00;
		else if(instr[15:11] == 5'b11101 && instr[7:0] == 8'b00000000)
			jorB = 2'b01;
		else if(instr[15:11] == 5'b00100 || instr[15:8] == 8'b01100000)
			jorB = 2'b10;
		else
			jorB = 2'b11;
	end
	
endmodule
