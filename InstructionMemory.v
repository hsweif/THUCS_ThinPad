`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:22:33 11/24/2018 
// Design Name: 
// Module Name:    InstructionMemory 
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
module InstructionMemory(
    input MemConflict,
	 input clk,
	 input rst,
    input [15:0] pc,
    output reg[15:0] Instruction
    );
 
// The size of fake memory
reg status = 0;
reg[15:0] memPool[0:3];
reg[15:0] lastPC;

always @(negedge rst)
begin
	memPool[0] = 16'b0100100000000001; //Reg 0 addiu 1
	memPool[1] = 16'b0100100100000001; //Reg 1 addiu 1
	memPool[2] = 16'b1110100000101100; //Reg0: Reg0 & Reg1
	memPool[3] = 16'b1110101000001111; //Reg2: ~Reg0
	lastPC <= 16'b0;
end

always @(negedge clk)
begin
	if(pc - lastPC == 4 || lastPC == 16'b0)
	begin
		if(status == 3)
			status = 0;
		else
			status = status + 1;
		lastPC[15:0] <= pc;
	end
	else
		;
end

always @(*)
begin
	Instruction[15:0] <= memPool[status];
end

endmodule
