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

endmodule
