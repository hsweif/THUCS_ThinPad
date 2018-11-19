`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:01:01 11/19/2018 
// Design Name: 
// Module Name:    ControlMem 
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
module ControlMem(
    input [15:0] instr,
    output reg[1:0] controlMem
    );

	always @(*) begin
		if(instr[15:11] == 5'b10010 || instr[15:11] == 5'b10011)
			controlMem = 2'b01;		// need memRead
		else if(instr[15:11] == 5'b11010 || instr[15:11] == 5'b11011)
			controlMem = 2'b10; 	// need memWrite
		else	
			controlMem = 2'b11;		// no mem operation
	end

endmodule
