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
	output reg [7:0] ledA,
	output reg [7:0] ledB,
	input wire rst,
    input wire clk,
	input [15:0] instr,
	input [3:0] writeBackReg,
	input [15:0] writeBackData,

    output reg [3:0] ALUOp,
    output reg [1:0] controlB,
    output reg [1:0] controlMem,
    output reg ifJump,
    output reg [15:0] immNum,
    output reg [1:0] jorB,
    output reg memToReg,
    output reg [3:0] readReg1,
    output reg [3:0] writeReg,

    output reg [3:0] readReg2,
    output reg [15:0] readData1,
    output reg [15:0] readData2

    );
	reg[15:0] register [15:0];
	integer i;
	always @(writeBackReg or instr) begin
		ledA[7:0] = register[1][15:8];
		ledB[7:0] = register[2][7:0];
		//ledA[7:4] = register[6][3:0];
		//ledA[3:0] = register[3][3:0];
		//ledB[7:4] = register[4][3:0];//register[writeBackReg][7:0];
		//ledB[3:0] = register[1][3:0];
	end
	/*always @(*) begin
		ledA[7:0] = instr[15:8];
		ledB[7:0] = instr[7:0];
	end*/
	always @(negedge clk or negedge rst) begin		
			if(rst == 0) begin
				register[0] <= 0;
				register[1] <= 0;
				register[2] <= 0;
				register[3] <= 0;
				register[4] <= 0;
				register[5] <= 0;
				register[6] <= 0;
				register[7] <= 0;
				register[8] <= 0;
				register[9] <= 0;
				register[10] <= 0;
				register[11] <= 0;
				register[12] <= 0;
				register[13] <= 0;
				register[14] <= 0;
				register[15] <= 0;
			end
        else if(writeBackReg != 15)begin
            register[writeBackReg] <= writeBackData;
        end
	end

	always @(readReg1 or readReg2) begin
		if(readReg1 == 4'b1111)	readData1 = 0;
        else if(readReg1 == writeBackReg) readData1 = writeBackData;
		else 					readData1 = register[readReg1];
		
		if(readReg2 == 4'b1111)	readData2 = 0;
        else if(readReg2 == writeBackReg) readData2 = writeBackData;
		else 					readData2 = register[readReg2];
	end

    always @(instr) begin
    	//readReg1
        if(instr[15:8] == 8'b01100011)                                      					readReg1 = 4'b1000;//SP
        else if(instr[15:11] == 5'b10010 || instr[15:11] == 5'b11010)                           readReg1 = 4'b1000;//SP
        else if(instr[15:8] == 8'b01100000)                                 					readReg1 = 4'b1001;//T
        else if(instr[15:11] == 5'b11110 && instr[4:0] == 0)                					readReg1 = 4'b1010;//IH
        else if(instr[15:8] == 8'b01100100 
        	|| instr[15:11] == 5'b00110 || instr[15:11] == 5'b01111)							readReg1 = {0, instr[7:5]};
        else if(instr[15:11] == 5'b11101 
        	&& (instr[4:0] == 5'b01111 || instr[4:0] == 5'b01011))								readReg1 = {0, instr[7:5]};
        else if(instr[15:11] == 5'b00001 || instr[15:11] == 5'b00010 || instr[15:11] == 5'b01101 
        	|| (instr[15:11] == 5'b11101 && instr[7:0] == 8'b01000000)) 						readReg1 = 4'b1111; //need zero
        else                                                                					readReg1 = {0, instr[10:8]};
        

		// readReg2
		if(instr[15:11] == 5'b11010)										readReg2 = {1'b0, instr[10:8]};
		else if(instr[15:11] == 5'b11011 || instr[15:11] == 5'b11100 || 
			(instr[15:11] == 5'b11101 
				&& (instr[4:0] == 5'b00010 || instr[4:0] == 5'b01101 
					|| instr[4:0] == 5'b01010 || instr[4:0] == 5'b01100))) 	readReg2 = {1'b0, instr[7:5]};
		else 																readReg2 = 4'b1111;

		//ALUop
        if(instr[15:11] == 5'b00100 || instr[15:11] == 5'b00101 || instr[15:8] == 8'b01100000 || (instr[15:11] == 5'b11100 && instr[1:0] == 2'b11))
            ALUOp = 4'b0001; //SUB
        else if(instr[15:11] == 5'b11101 && instr[4:0] == 5'b01100)
            ALUOp = 4'b0010; //AND
        else if(instr[15:11] == 5'b11101 && instr[4:0] == 5'b01011)
            ALUOp = 4'b0100; //NEG
        else if(instr[15:11] == 5'b11101 && instr[4:0] == 5'b01111)
            ALUOp = 4'b0101; //NOT
        else if(instr[15:11] == 5'b11101 && instr[4:0] == 5'b01101)
            ALUOp = 4'b0011; //OR
        else if(instr[15:11] == 5'b00110 && instr[1:0] == 2'b00)
            ALUOp = 4'b0110; //SLL
        else if(instr[15:11] == 5'b00110 && instr[1:0] == 2'b11)
            ALUOp = 4'b1000; //SRA
        else if(instr[15:11] == 5'b01011 || (instr[15:11] == 5'b11101 && instr[4:0] == 5'b00010))
            ALUOp = 4'b1001; //SLT,SLTUI对应
        else if(instr[15:11] == 5'b11101 && instr[4:0] == 5'b01010)
            ALUOp = 4'b1010; //CMP对应
        else
            ALUOp = 4'b0000; //ADD, default value

        //controlB
        if((instr[15:11] == 5'b11100 && (instr[1:0] == 2'b01 || instr[1:0] == 2'b11)) || (instr[15:11] == 5'b11101 && (instr[4:0] == 5'b01100 || instr[4:0] == 5'b01010 || instr[4:0] == 5'b01011 || instr[4:0] == 5'b01101 || instr[4:0] == 5'b00010)) || (instr[15:11] == 5'b01111 && instr[4:0] == 5'b00000))
            controlB = 2'b00; //ry
        else if((instr[15:11] == 5'b00110 && (instr[1:0] == 2'b00 || instr[1:0] == 2'b11)) || instr[15:11] == 5'b01000 || instr[15:11] == 5'b01001 || instr[15:11] == 5'b01011 || instr[15:8] == 8'b01100011 || instr[15:11] == 5'b01101 || instr[15:11] == 5'b10010 || instr[15:11] == 5'b10011 || instr[15:11] == 5'b11010 || instr[15:11] == 5'b11011)
            controlB = 2'b01; //imm
        else
            controlB = 2'b10; // default value, 0

        //controlMem
        if(instr[15:11] == 5'b10010 || instr[15:11] == 5'b10011)
            controlMem = 2'b01;     // need memRead
        else if(instr[15:11] == 5'b11010 || instr[15:11] == 5'b11011)
            controlMem = 2'b10;     // need memWrite
        else    
            controlMem = 2'b11;     // no mem operation

        //ifJump
        if(instr[15:11] == 5'b00010 || instr[15:11] == 5'b00100 || instr[15:11] == 5'b00101 || instr[15:11] == 5'b01100 || (instr[15:11] == 5'b11101 && instr[7:0] == 8'b00000000))
            ifJump = 0;
        else
            ifJump = 1;

        //immNum
        if(instr[15:11] == 5'b01001 || instr[15:8] == 8'b01100011 || instr[15:11] == 5'b00100 || instr[15:11] == 5'b00101 || instr[15:8] == 8'b01100000 || instr[15:11] == 5'b10010 || instr[15:11] == 5'b11010)
            immNum = { {8{instr[7]}}, instr[7:0]};
        else if(instr[15:11] == 5'b01000 && instr[4] == 0)
            immNum = { {12{instr[3]}}, instr[3:0]};
        else if(instr[15:11] == 5'b00010)
            immNum = { {5{instr[10]}}, instr[10:0]};
        else if(instr[15:11] == 5'b10011 || instr[15:11] == 5'b11011)
            immNum = { {11{instr[4]}}, instr[4:0]};
        else if(instr[15:11] == 5'b00110)
            immNum = { {13{0}}, instr[4:2]};
        else if(instr[15:11] == 5'b01101 || instr[15:11] == 5'b01011)
            immNum = { 8'b00000000, instr[7:0]};
        else
            immNum = 0;

        //jorB       00:B 01:J 10:B== 11:B!=
        if(instr[15:11] == 5'b00010)
            jorB = 2'b00;
        else if(instr[15:11] == 5'b11101 && instr[7:0] == 8'b00000000)
            jorB = 2'b01;
        else if(instr[15:11] == 5'b00100 || instr[15:8] == 8'b01100000)
            jorB = 2'b10;
        else
            jorB = 2'b11;

        //memToReg
        if(instr[15:11] == 5'b10010 || instr[15:11] == 5'b10011)
            memToReg = 0;   //Mem
        else
            memToReg = 1;   // default value, alu result

        //writeReg
        if(instr[15:8] == 8'b01100011 || instr[15:8] == 8'b01100100)
            writeReg = 4'b1000; //SP
        else if((instr[15:11] == 5'b11101 && (instr[4:0] == 5'b01010 || instr[4:0] == 5'b00010)) || instr[15:11] == 5'b01011)
            writeReg = 4'b1001; //T
        else if(instr[15:11] == 5'b11110 && instr[4:0] == 5'b00001)
            writeReg = 4'b1010; //IH
        else if(instr[15:11] == 5'b11100 && (instr[1:0] == 2'b01 || instr[1:0] == 2'b11))
            writeReg = {0, instr[4:2]};
        else if(instr[15:11] == 5'b10011 || instr[15:11] == 5'b01000)
            writeReg = {0, instr[7:5]};
        else if(instr[15:11] == 5'b00001 || instr[15:11] == 5'b00010 || instr[15:11] == 5'b00100 || instr[15:11] == 5'b00101 || instr[15:8] == 8'b01100000 || (instr[15:11] == 5'b11101 && instr[7:0] == 8'b00000000) || instr[15:0] == 16'b00000000000 || instr[15:11] == 5'b11011 || instr[15:11] == 5'b11010)
            writeReg = 4'b1111; //don't need to write Reg
        else
            writeReg = {0, instr[10:8]};


		if(instr[15:11] == 5'b00110) begin
			if(immNum == 0)		immNum = 8;
		end

    end

endmodule
