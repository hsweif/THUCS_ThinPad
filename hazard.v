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
	input error,
	input [3:0] readReg1,
	input [3:0] readReg2,
	input [3:0] writeReg,
	input [1:0] controlMem,
	input memConflict,
	input uartConflict,
	output reg ifKeep,
	output reg pcKeep,
	output reg idKeep,
	output reg exeKeep,
	output reg idClear,
	output reg ifClear
    );
	
	wire RAC;
	assign RAC = controlMem[1] == 0 && writeReg != 4'b1111 && (readReg1 == writeReg || readReg2 == writeReg);

	always@(*) begin
		if(uartConflict == 0)  		idKeep = 1;
		else 						idKeep = 0;
		if(uartConflict == 0) 		exeKeep = 1;
		else 						exeKeep = 0;
		if(memConflict == 1 || RAC || uartConflict == 0)	pcKeep = 1;
		else 						pcKeep = 0;

		if(RAC || uartConflict == 0)	ifKeep = 1;
		else 	ifKeep = 0;

		if(memConflict == 1 || error == 1)	ifClear = 1;
		else 								ifClear = 0;

		if(RAC)	idClear = 1;
		else 	idClear = 0;
	end

endmodule
