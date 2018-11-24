`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:02:51 11/24/2018 
// Design Name: 
// Module Name:    ID 
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
module ID(
	input [15:0] instr,
	input [3:0] writeBackReg,
	input [15:0] writeBackData,

    output [3:0] ALUOp,
    output [1:0] controlB,
    output [1:0] controlMem,
    output ifJump,
    output [15:0] immNum,
    output [1:0] jorB,
    output memToReg,
    output [3:0] readReg1,
    output [3:0] writeReg,

    output [3:0] readReg2,
    output [15:0] readData1,
    output [15:0] readData2

    );
	
	reg[15:0] register [15:0];
	wire reg1Index;
	wire reg2Index;
	wire writeIndex;

	control ctl(.instr(instr), .ALUOp(ALUOp), .controlB(controlB), .controlMem(controlMem),
		.ifJump(ifJump), .immNum(immNum), .jorB(jorB), .memToReg(memToReg),
		.readReg1(readReg1), .writeReg(writeReg));

	assign readReg2 = {1'b0, instr[7:5]};
	assign reg1Index = readReg1[3]*8+readReg1[2]*4+readReg1[1]*2+readReg1[0];
	assign reg2Index = readReg2[3]*8+readReg2[2]*4+readReg2[1]*2+readReg2[0];
	assign writeIndex = writeBackReg[3]*8+writeBackReg[2]*4+writeBackReg[1]*2+writeBackReg[0];

	assign readData1 = register[reg1Index];
	assign readData2 = register[reg2Index];

	always @(*) begin
		// error may be right here, fix me
		register[writeIndex] = writeBackData;
	end

endmodule
