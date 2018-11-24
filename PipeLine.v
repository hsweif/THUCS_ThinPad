`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:59:57 11/24/2018 
// Design Name: 
// Module Name:    PipeLine 
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
module PipeLine(
	input clk,
	input rst,
	output [15:0] led
    );

wire [15:0] pc;
wire [15:0] addedPc;
wire [15:0] instruction;

// output and input of ID
wire [3:0] writeBackReg; 
wire [15:0] writeBackData;
wire [3:0] ALUOp;
wire [1:0] controlB;
wire [1:0] controlMem;
wire ifJump;
wire [15:0] immNum;
wire [1:0] jorB;
wire memToReg;
wire [3:0] readReg1;
wire [3:0] writeReg;
wire [3:0] readReg2;
wire [15:0] readData1;
wire [15:0] readData2;


PC_reg _PC_reg(
	.clk (clk),
	.rst (rst),
	.pc (pc),
	.addedPc (AddedPC)
);

InstructionMemory _IM(
	.clk (clk),
	.rst (rst),
	.pc (pc),
	.Instruction (instruction)
);

Exe _Exe(
	.clk (clk)
);

WriteBack _wb(
	.clk (clk)
);

Forwarding _forward(
	
);

ID _ID(
	.instr(instruction),
	.writeBackReg(writeBackReg),
	.writeBackData(writeBackData),

    .ALUOp(ALUOp),
    .controlB(controlB),
    .controlMem(controlMem),
    .ifJump(ifJump),
    .immNum(immNum),
    .jorB(jorB),
    .memToReg(memToReg),
    .readReg1(readReg1),
    .writeReg(writeReg),
    .readReg2(readReg2),
    .readData1(readData1),
    .readData2(readData2)
);

endmodule
