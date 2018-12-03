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
	output reg ifKeep,
	output reg pcKeep,
	output reg idClear,
	output reg idKeep,
	output reg ifClear,
	output reg exeKeep
    );
	
	wire RAC;
	assign RAC = controlMem[1] == 0 && writeReg != 4'b1111 && (readReg1 == writeReg || readReg2 == writeReg);

	always@(*) begin
		if(memConflict == 1)	exeKeep = 1;
		else 					exeKeep = 0;
		
		if(memConflict == 1) 	idKeep = 1;
		else 					idKeep = 0;

		if(memConflict == 1 || RAC  == 1)	pcKeep = 1;
		else 						pcKeep = 0;

		if(RAC == 1 || memConflict == 1)	ifKeep = 1;
		else 	ifKeep = 0;

		if(error == 1)						ifClear = 1;
		else 								ifClear = 0;

		if(RAC)	idClear = 1;
		else 	idClear = 0;
		// if(memConflict == 1 || RAC  == 1)	pcKeep = 1;
		// else 						pcKeep = 0;

		// if(RAC == 1)	ifKeep = 1;
		// else 	ifKeep = 0;

		// if(memConflict == 1 || error == 1)	ifClear = 1;
		// else 								ifClear = 0;

		// if(RAC)	idClear = 1;
		// else 	idClear = 0;
	end

endmodule
