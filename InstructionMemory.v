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
reg [5:0] status = 6'b000000;
reg[15:0] memPool[0:39];
reg[15:0] lastPC;

always @(negedge rst)
begin
	memPool[0] = 16'b0100101000000101; //Reg 2 addiu 5 
	//16'b0110100000001111; //LI Reg0 15
	memPool[1] = 16'b1101100001000100; //SW M[R0+4] <- R1  4<-5
	// 16'b0110110100000011; //LI Reg5 3
	//16'b0100110100000011; //Reg 5 addiu 3
	memPool[2] = 16'b0010000000000001; //BEQZ R0 == 0 ? PC+4: PC;
	//16'b1001100000100100; //LW R1 <- M[R0+4] 5
	//16'b1110110101001010; //CMP(R2, R5) T <- 1 
	//16'b0010000000000100; //BEQZ R0 == 0 ? PC+16: PC;
	//16'b1110100000101100; //Reg0: Reg0 & Reg1
	memPool[3] = 16'b0000100000000000; //nop
	//16'b1110110110101010; //CMP(R5, R5) T <- 0
	//16'b1110000000110011; //SUBU R4 <- R0 - R1 -5
	//16'b1110101000001111; //Reg2: ~Reg0
	memPool[4] = 16'b1110000101000001; //ADDU R1 R2 -> R0 10+10 = 20
	//16'b1110010101000101; //ADDU R5 R2 -> R1 8 (13
	//16'b0010000100000001; // R1 == 0 ? PC+4: PC;
	//16'b0110100100000011; //LI Reg1 3
	memPool[5] = 16'b1110010100110011; //SUBU R4 <- R5 - R1 -5 (-10
	//16'b0000100000000000; //nop
	//16'b0110101000000101; //LI Reg2 5
	memPool[6] = 16'b1110000001001001; //ADDU R0 R2 -> R2 30 (10
	//16'b0110101110000000; //LI Reg3 0x80
	memPool[7] = 16'b1110100101001101; //OR R1 <- R2 | R1 1111(15) (1111)
	//16'b0110110000001001; //LI Reg4 9
	memPool[8] =  16'b1110000101000101; //ADDU R1 R2 -> R1 30 (25
	memPool[9] =  16'b1101100000100100; //SW M[R0+4] <- R1 4 (
	memPool[10] = 16'b1110000101001001; //ADDU R1 R2 -> R2 45 (35
	//16'b0100110011111111; //ADDIU R4 FF
	memPool[11] = 16'b1001110000001110; //LW R0 <- M[R4+9(14)] 4 (26
	//16'b1110100101000010; //SLT R1 R2 T <- 1 
	//16'b0011010110000000; //SLL R5 <- R4<<8	
	memPool[12] = 16'b1110000001001001; //ADDU R0 R2 -> R2 15
	//16'b0101100100000011; //SLTUI R1 3  T <- 0
	//16'b0011011010001100; //SLL R6 <- R4<<3
	memPool[13] = 16'b0101100100100011; //SLTUI R1 100011  T <- 1
	//16'b0011011110000011; //SRA R7 <- R4>>8
	memPool[14] = 16'b1110100100000010; //SLT R1 R0 T <- 0
	//16'b0011000010010011; //SRA R0 <- R4>>4
	memPool[15] = 16'b0110001100001100; //ADDSP SP <- SP + 12
	//16'b0100000000101011; //ADDIU3 R1 <- R0 + 11
	memPool[16] = 16'b1101001000000100; //SW_SP M[SP+4] <- R2 16
	//16'b0110100100000011; //LI Reg1 3
	memPool[17] = 16'b1001110000001001; //LW R0 <- M[R4+9] 4 (26
	//16'b0101100100000000; //SLTUI R1 0  T <- 0
	memPool[18] = 16'b1001001100000100; //LW_SP R3 <- M[SP+4] 16
	//16'b0101100111111111; //SLTUI R1 FF T <- 1
	memPool[19] = 16'b1110110101101100; //AND R5 <- R3 & R5
	//16'b0110010000100000; //MTSP SP <- R1(3)
	memPool[20] = 16'b1110110100000000;
	//16'b0110001100001100; //ADDSP SP <- SP + 12
	memPool[21] = 16'b0000100000000000;
	//16'b0111100000100000; //MOVE R0 <- R1
	memPool[22] = 16'b0111100000100000;
	//16'b1101100000100100; //SW M[R0+4] <- R1
	memPool[23] = 16'b1101000000000100; //SW_SP M[SP+4] <- R0
	memPool[24] = 16'b0110101010110101; //LI Reg2 ***
	memPool[25] = 16'b0110101101101011; //LI Reg3 ***
	memPool[26] = 16'b1110001001110011; //SUBU R4 <- R2 - R3
	memPool[27] = 16'b1110110101101100; //AND R5 <- R3 & R5
	memPool[28] = 16'b1110110110101010; //CMP(R5, R5) T <- 0
 	memPool[29] = 16'b1110110110001010; //CMP(R4, R5) T <- 1
	memPool[30] = 16'b1110111001000000; //MFPC R6 <- PC
	memPool[31] = 16'b1110111111001011; //NEG R7 <- 0 - R6
	memPool[32] = 16'b1110100011101111; //NOT R0 <- ~R7
	memPool[33] = 16'b1110100100001101; //OR R1 <- R0 | R1
	memPool[34] = 16'b1110100100000010; //SLT R1 R0 T <- 0
	memPool[35] = 16'b1110100000100010; //SLT R0 R1 T <- 1
	memPool[36] = 16'b1111000100000001; //MTIH IH <- R1
	memPool[37] = 16'b1111001000000000; //MFIH R2 <- IH
	memPool[38] = 16'b1001101000000100; //LW R0 <- M[R2+4]
	memPool[39] = 16'b1001001100000100; //LW_SP R3 <- M[SP+4]

	// lastPC <= 16'b0;
	status <= 0;
end

always @(*) begin
	status = (pc >> 2) % 32; 
end

always @(*)
begin
	// if(pc - lastPC == 4 || lastPC == 16'b0)
	// begin
	// 	if(status == 22)
	// 		status <= 0;
	// 	else
	// 		status <= status + 1;
	// 	lastPC[15:0] <= pc;
	// 	Instruction[15:0] <= memPool[status];
	// end
	// status <= (pc >> 2) % 39;
	// lastPC[15:0] <= pc;
	Instruction[15:0] <= memPool[(pc >> 2) % 32];
end

endmodule
