`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:40:08 11/19/2018 
// Design Name: 
// Module Name:    WriteReg 
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
module WriteReg(
    input [15:0] instr,
    output reg[3:0] writeReg
    );
	 
	always @(*) begin
		if(instr[15:8] == 8'b01100011 || instr[15:8] == 8'b01100100)
			writeReg = 4'b1000;	//SP
		else if((instr[15:11] == 5'b11101 && (instr[4:0] == 5'b01010 || instr[4:0] == 5'b00010)) || instr[15:11] == 5'b01011)
			writeReg = 4'b1001; //T
		else if(instr[15:11] == 5'b11110 && instr[4:0] == 5'b00001)
			writeReg = 4'b1010; //IH
		else if(instr[15:11] == 5'b11100 && (instr[1:0] == 2'b01 || instr[1:0] == 2'b11))
			writeReg = {0, instr[4:2]};
		else if(instr[15:11] == 'b10011)
			writeReg = {0, instr[7:5]};
		else if(instr[15:11] == 5'b00010 || instr[15:11] == 5'b00100 || instr[15:11] == 5'b00101 || instr[15:8] == 8'b01100000 || (instr[15:11] == 5'b11101 && instr[7:0] == 8'b00000000) || instr[15:0] == 16'b0000100000000000 || instr[15:11] == 5'b11011 || instr[15:11] == 5'b11010)
			writeReg = 4'b1111; //don't need to write Reg
		else
			writeReg = {0, instr[10:8]};
	end


endmodule
