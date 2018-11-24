`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:42:46 11/24/2018 
// Design Name: 
// Module Name:    control 
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
module control(
    input [15:0] instr,
    output [3:0] ALUOp,
    output [1:0] controlB,
    output [1:0] controlMem,
    output ifJump,
    output [15:0] immNum,
    output [1:0] jorB,
    output memToReg,
    output [3:0] readReg1,
    output [3:0] writeReg
    );
	ALUOp alu(		.instr(instr), .ALUOp(ALUOp));
	ControlB ctB(	.instr(instr), .controlB(controlB));
	ControlMem ctM(	.instr(instr), .controlMem(controlMem));
	IfJump ifJp(	.instr(instr), .ifJump(ifJump));
	ImmNum imm(		.instr(instr), .immNum(immNum));
	JorB jb(		.instr(instr), .jorB(jorB));
	MemToReg mtr(	.instr(instr), .memToReg(memToReg));
	ReadReg1 rr(	.instr(instr), .readReg(readReg1));
	WriteReg wr(	.instr(instr), .writeReg(writeReg));

endmodule
