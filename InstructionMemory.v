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
	// Below for command is for testing uart.
	memPool[0]  <= 16'b0000100000000000;
	memPool[1]  <= 16'b0110100110111111; //LI r1 BF
	memPool[2]  <= 16'b0011000100100000;//SLL r1<<8
	memPool[3]  <= 16'b1001100101000000; //LW r2 = M[R1+0]
	memPool[4]  <= 16'b1101100101000000;	//SW 	M[r1] <- r2 (BF)

	// Below is original test.
	// memPool[0]  <= 16'b0100100100000111; //Reg1 addiu 7
	// memPool[1]  <= 16'b0110101011001111; //LI 	r2 <- CF
	// memPool[2]  <= 16'b0011001101000000; //SLL 	r3 <- r2 << 8 CF00
	// memPool[3]  <= 16'b1101101101100000;	//SW 	M[r3] <- r3 (CF02 -> CF00)
	// memPool[4]  <= 16'b1101100000101000;	//SW 	M[r0+8] <- r1 (0000 -> 7)
	memPool[5]  <= 16'b1101101101000100;	//SW 	M[r3+4] <- r2 (CF02 -> CF)
	memPool[6]  <= 16'b1001101111000100;	//LW 	r6 <- M[r3+4] CF
	//16'b1001101111000000;	//LW 	r6 <- M[r3] CF00
	memPool[7]  <= 16'b1110011000101011;		//SUBU		r2 <- r6-r1 = C8
	//16'b1001101111100000;	//LW 	r7 <- M[r3] CF00
	memPool[8]  <= 16'b1001101110000000;	//LW 	r4 <- M[r3] CF00
	//16'b1001101111000000;	//LW 	r6 <- M[r3] CF00
	memPool[9]  <= 16'b1001100010101000;	//LW 	r5 <- M[r0+8] 7
	memPool[10] <= 16'b1110110001001101;		//OR 		r4 <- r4|r2 CFC8
	memPool[11] <= 16'b1101110010000011;	//SW 	M[r4+3(CFCB)] <- r4 (CFCB -> CFC8)
	memPool[12] <= 16'b1101100101001010;	//SW 	M[r1+10] <- r2 (17 -> C8)
	memPool[13] <= 16'b1001110000000011;	//LW 	r0 <- M[r4+3] CFC8 
	memPool[14] <= 16'b1001100111101010;	//LW 	r7 <- M[r1+10] C8 
	memPool[15] <= 16'b1001110000100011;	//LW 	r1 <- M[r4+3] CFC8 
	memPool[16] <= 16'b1110000110101111;	//SUBU	r3 <- r1-r5 = C1
	memPool[17] <= 16'b0000100000000000; //nop
	//16'b1001101110100100;	//LW 	r5 <- M[r3+4] 14
	memPool[18] <= 16'b0000100000000000; //nop
	//16'b1110010010110101;	//ADDU   	r5 <- r4+r5 
	memPool[19] <= 16'b0000100000000000; //nop
	memPool[20] <= 16'b0000100000000000; //nop
	memPool[21] <= 16'b1110000110101011;	//SUBU	r2 <- r1-r5 = C1
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
	// if ((pc >> 2) < 22)
		// Instruction[15:0] = memPool[(pc >> 2) % 64];
	// Testing uart now.
	if ((pc >> 2) < 5)
		Instruction[15:0] = memPool[(pc >> 2) % 32];
	else
		Instruction[15:0] = 16'b0000100000000000; //nop
end

endmodule
