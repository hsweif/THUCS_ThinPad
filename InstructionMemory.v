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
  //  input MemConflict,
	 input clk,
	 input rst,
    input [15:0] pc,
    output reg[15:0] Instruction
	 //output reg [7:0] ledB,
	 //output reg [7:0] ledA
    );
 
// The size of fake memory
reg [5:0] status = 6'b000000;
reg[15:0] memPool[0:32];
reg[15:0] lastPC;

/* 根据指令名称字典序排序，便于测试，请勿修�*/
// 	16'b01000 rx ry 0 imm(4)  	//ADDIU3 	ry <- rx+imm  
// 	16'b01001 rx imm(8)			//ADDIU  	rx <- rx+imm
// 	16'b01100011 imm(8)			//ADDSP  	SP <- SP+imm
// 	16'b11100 rx ry rz 01		//ADDU   	rz <- rx+ry
// 	16'b11101 rx ry 01100       //AND    	rx <- rx&rz
// 	16'b00010 imm(11)   		//B 		pc <- pc + imm
// 	16'b00100 rx imm(8) 		//BEQZ 		rx==0 ? pc+imm : pc	
// 	16'b00101 rx imm(8)    		//BNEZ 		rx!=0 ? pc+imm : pc
// 	16'b01100000 imm(8) 		//BTEQZ 	T==0 ? pc+imm : pc
// 	16'b11101 rx ry 01010 		//CMP 		T <- (rx==ry ? 0 : 1)
// 	16'b11101 rx 00000000 		//JR 		PC <- rx
// 	16'b01101 rx imm(8)			//LI 		rx <- zeroExtend(imm)
// 	16'b10011 rx ry imm(5)		//LW 		ry <- M[rx+imm]
// 	16'b10010 rx imm(8)			//LW_SP 	rx <- M[SP+imm]
// 	16'b11110 rx 00000000 		//MFIH 		rx <- IH
// 	16'b11101 rx 01000000  		//MFPC 		rx <- PC
// 	16'b01111 rx ry 00000		//MOVE		rx <- ry
// 	16'b11110 rx 00000001 		//MTIH 		IH <- rx
// 	16'b01100100 rx 00000 		//MTSP 		SP <- rx
// 	16'b11101 rx ry 01011 		//NEG 		rx <- 0-ry
// 	16'b11101 rx ry 01111 		//NOT 		rx <- ~ry
// 	16'b0000100000000000 		//nop
// 	16'b11101 rx ry 01101		//OR 		rx <- rx|ry
// 	16'b00110 rx ry imm(3) 00 	//SLL 		rx <- ry << (imm==0 ? 8 : imm)
// 	16'b11101 rx ry 00010		//SLT  		T <- (rx<ry ? 1 : 0)
// 	16'b01011 rx imm(8)			//SLTUI		T <- (rx<zE(imm) ? 1 : 0)
// 	16'b00110 rx ry imm(3) 11 	//SRA 		rx <- ry >> (imm==0 ? 8 : imm)
// 	16'b11100 rx ry rz 11		//SUBU		rz <- rx-ry
// 	16'b11011 rx ry imm(5)		//SW 		M[rx+imm] <- ry
// 	16'b11010 rx imm(8)			//SW_SP		M[SP+imm] <- ry
always @(negedge rst)
begin
	memPool[0]  <= 16'b0100100100000111; //Reg1 addiu 7
	memPool[1]  <= 16'b0110101011001111; //LI 	r2 <- CF
	memPool[2]  <= 16'b0011001001000000; //SLL 	r2 <- r2 << 8 CF00
	memPool[3]  <= 16'b1101101000100001;	//SW 	M[r2+1] <- ry (CF01 -> 7)
	memPool[4]  <= 16'b1001101001100001;	//LW 	r3 <- M[r2+1] 7
	memPool[5]  <= 16'b1110000001110011;	//SUBU r4 <- r0-r3 (-7)
	memPool[6]  <= 16'b1101100010000001;	//SW 	M[r0+1] <- r4 (01 -> -7)
	memPool[7]  <= 16'b1001101010100001;	//LW 	r5 <- M[r2+1] 7
	memPool[8]  <= 16'b1110000010111011;	//SUBU r6 <- r0-r5 (-7)
	memPool[9]  <= 16'b1101100000100001;	//SW 	M[r0+1] <- r1 (01 -> 7)
	memPool[10] <= 16'b0110000000000010;   //BTEQZ pc+8
	memPool[11] <= 16'b0100100100000001; //Reg1 addiu 1
	memPool[12] <= 16'b0100100100000010; //Reg1 addiu 2
	memPool[13] <= 16'b0100100100000100; //Reg1 addiu 4
	memPool[14] <= 16'b1001100000000001;	//LW 	r0 <- M[r0+1] 7
	memPool[15] <= 16'b0100101000000001; //Reg2 addiu 1 	
	memPool[16] <= 16'b0100001001100001; //ADDIU3 	r3 <- r2+1
	memPool[17] <= 16'b0000100000000000; //nop;//16'b1001111110001111;	//LW 		r4 <- M[r7+imm] 
	memPool[18] <= 16'b1110010010110101;	//ADDU   	r5 <- r4+r5 
	memPool[19] <= 16'b0100100111111111; //R1-=1;
	memPool[20] <= 16'b0010100111111010; //BEQZ 		r1==0 ? pc+imm : pc	
	memPool[21] <= 16'b0000100000000000; //nop
	memPool[22] <= 16'b0100100011111111; //R0-=1;
	memPool[23] <= 16'b0010100011110110; //BEQZ 		r0==0 ? pc+imm : pc
	memPool[24] <= 16'b0000100000000000; //nop;
	memPool[25] <= 16'b0100111011111111; //ADDIU R6 FF
	memPool[26] <= 16'b0110110100000001; //LI r5 1
	memPool[27] <= 16'b0000100000000000; //nop
	memPool[28] <= 16'b0000100000000000; //nop
 	memPool[29] <= 16'b0000100000000000; //nop
	memPool[30] <= 16'b0000100000000000; //nop
	memPool[31] <= 16'b0000100000000000; //nop
	memPool[32] <= 16'b0000100000000000; //nop
	status <= 0;
end

always @(*) begin
	status = (pc >> 2) % 64; 
end

always @(pc) begin
	if ((pc >> 2) < 15)
		Instruction[15:0] = memPool[(pc >> 2) % 64];
	else
		Instruction[15:0] = 16'b0000100000000000; //nop
end

endmodule
