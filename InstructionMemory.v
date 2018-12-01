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
reg[15:0] memPool[0:39];
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
// 	16'b00110 rx ry imm(3) 00 	//SRA 		rx <- ry >> (imm==0 ? 8 : imm)
// 	16'b11100 rx ry rz 11		//SUBU		rz <- rx-ry
// 	16'b11011 rx ry imm(5)		//SW 		M[rx+imm] <- ry
// 	16'b11010 rx imm(8)			//SW_SP		M[SP+imm] <- ry
always @(negedge rst)
begin
	memPool[0]  <= 16'b0000100000000000;
	memPool[1]  <= 16'b0100100111111111; //ADDIU R1 FF = -1
	memPool[2]  <= 16'b0100000101000111; //ADDIU3 	(r2 <- r1+7) = 6  
	memPool[3]  <= 16'b0110001100000010;//ADDSP  (SP <- SP+2) = 2
	memPool[4]  <= 16'b1110000101001001;//ADDU   	r2 <- r1+r2 = 5
	memPool[5]  <= 16'b1110000000101111;//SUBU		r3 <- r0-r1 = 1
	memPool[6]  <= 16'b0100101100000010; //ADDIU R3 2 = 3
	memPool[7]  <= 16'b1110101101001100;//AND   r3 <- r3&r2 = 3
	memPool[8]  <= 16'b0001000000000011;//B pc <- pc + 3
	memPool[9]  <= 16'b0000100000000000;	//nop
	memPool[10] <= 16'b0100100100000001; //Reg1 addiu 1
	memPool[11] <= 16'b0100100100000001; //Reg1 addiu 1
	memPool[12] <= 16'b0010000000000010; //BEQZ r0->pc+8
	memPool[13] <= 16'b0100100100000001; //Reg1 addiu 1 = 2
	memPool[14] <= 16'b1111000100000001; //MTIH IH <- R1 = 2
	memPool[15] <= 16'b1111010000000000; //MFIH R4 <- IH = 2	
	memPool[16] <= 16'b0111100010000000; //MOVE R0 <- R4 = 2
	memPool[17] <= 16'b0110010001000000; //MTSP 	SP <- r2 = 5
	memPool[18] <= 16'b1110110101000000; //MFPC r5 <- PC 1001000
	memPool[19] <= 16'b1110110101101101; //OR r5 <- r5|r3 = 1001011
	memPool[20] <= 16'b1110100000001011; //NEG r0 <- 0-r0 = -2
	memPool[21] <= 16'b1110110110101111; //NOT R5 <- ~R5 = 1111111110110111
	memPool[22] <= 16'b0011010110101000; 	//SLL r5 <- r5 << 2 1111111011011100
	memPool[23] <= 16'b1101010100000100; //SW_SP	M[SP+4] <- r5
	//16'b0010100011110110; //BEQZ 		r0==0 ? pc+imm : pc
	memPool[24] <= 16'b1001011000000100; //LW_SP R6 <- M[SP+4=(9)]
	memPool[25] <= 16'b1110110111001010; //CMP(R6, R5) T <- 1
	memPool[26] <= 16'b0110000001111111; //BTEQZ 	T==0 ? pc+imm : pc (pc)
	memPool[27] <= 16'b0000100000000000; //nop
	memPool[28] <= 16'b1101100000000100;	//SW 	M[r0+imm] <- r0
 	memPool[29] <= 16'b1001100011100100; //LW R7 <- M[R0+4=(2)] = -2
	memPool[30] <= 16'b0011010110100100; 	//SRA r5 <- r5 >> 11111111101101110
	memPool[31] <= 16'b1110110110101011; //NEG R5 <- 0 - R5 0000000010010001
	memPool[32] <= 16'b1110110100000000; //JR PC <- r5 (36)
	memPool[33] <= 16'b0000100000000000; //nop
	memPool[34] <= 16'b0100100100000001; //Reg1 addiu 1
	memPool[35] <= 16'b0100100100000001; //Reg1 addiu 1
	memPool[36] <= 16'b0101110110010000; //SLTUI T <- (rx<zE(imm) ? 1 : 0)
	memPool[37] <= 16'b0000100000000000; //nop
	memPool[38] <= 16'b0000100000000000; //nop
	memPool[39] <= 16'b0000100000000000; //nop
	status <= 0;
end

always @(*) begin
	status = (pc >> 2) % 32; 
end

always @(pc) begin
	if ((pc >> 2) < 39)
		Instruction[15:0] = memPool[(pc >> 2) % 32];
	else
		Instruction[15:0] = 16'b0000100000000000; //nop
end

endmodule
