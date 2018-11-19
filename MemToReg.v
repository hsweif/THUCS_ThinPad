`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:53:50 11/19/2018 
// Design Name: 
// Module Name:    MemToReg 
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
module MemToReg(
    input [15:0] instr,
    output reg memToReg
    );
	
	always @(*) begin
		if(instr[15:11] == 5'b10010 || instr[15:11] == 5'b10011)
			memToReg = 0;	//Mem
		else
			memToReg = 1;	// default value, alu result
	end

endmodule
