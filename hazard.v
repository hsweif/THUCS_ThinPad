`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:20:33 11/26/2018 
// Design Name: 
// Module Name:    hazard 
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
module hazard(
	input clk,
	input [3:0] readReg1,
	input [3:0] readReg2,
	input [3:0] writeReg,
	input [1:0] controlMem,
	output reg ifKeep,
	output reg pcKeep,
	output reg idKeep,
	output reg ifKeep2,
	output reg pcKeep2,
	output reg idKeep2
    );

	always@(*) begin
		if(controlMem[1] == 0 && writeReg != 4'b1111 && (readReg1 == writeReg || readReg2 == writeReg)) begin
			ifKeep = 1;
			pcKeep = 1;
			idKeep = 1;
		end
		else begin
			ifKeep = 0;
			pcKeep = 0;
			idKeep = 0;
		end
	end

endmodule
