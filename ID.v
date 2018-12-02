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
    output reg [3:0] writeReg,
    output reg [3:0] readReg1,
    output reg [3:0] readReg2,
    output reg [15:0] readData1,
    output reg [15:0] readData2
);

    reg[15:0] register [15:0];

    always @(writeBackReg or instr) begin
        /*ledA[7:4] = register[6][7:4];
        ledA[3:0] = register[6][3:0];
        ledB[7:4] = register[4][3:0];
        ledB[3:0] = register[3][3:0];
		  ledA[7:4] = register[2][15:12];
		  ledA[3:0] = register[2][11:8];
		  ledB[7:4] = register[2][7:4];
		  ledB[3:0] = register[2][3:0];
		  */
		  // Below is for testing uart.
		  ledA[7:0] = register[1][15:8];
		  ledB[3:0] = register[2][3:0];
    end

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

    always @(readReg1 or readReg2 or writeBackData or writeBackReg) begin
        if(readReg1 == 4'b1111)             readData1 = 0;
        else if(readReg1 == writeBackReg)   readData1 = writeBackData;
        else                                readData1 = register[readReg1];
        
        if(readReg2 == 4'b1111)             readData2 = 0;
        else if(readReg2 == writeBackReg)   readData2 = writeBackData;
        else                                readData2 = register[readReg2];
    end
    
    always @(instr) begin
        case(instr[15:11])
            5'b00001: begin 
                readReg1 = 4'b1111;       
                readReg2 = 4'b1111;
                ALUOp = 4'b0000;
                controlB = 2'b10;
                controlMem = 2'b11;
                ifJump = 1;
                immNum = 0;
                jorB = 2'b11;
                memToReg = 1;
                writeReg = 4'b1111;
            end
            5'b00010: begin 
                readReg1 = 4'b1111;         
                readReg2 = 4'b1111;
                ALUOp = 4'b0000;
                controlB = 2'b10;
                controlMem = 2'b11;
                ifJump = 0;
                immNum = { {5{instr[10]}}, instr[10:0]};
                jorB = 2'b00;
                memToReg = 1;
                writeReg = 4'b1111;
            end
            5'b00100: begin 
                readReg1 = {0, instr[10:8]};
                readReg2 = 4'b1111;
                ALUOp = 4'b0001;
                controlB = 2'b10;
                controlMem = 2'b11;
                ifJump = 0;
                immNum = { {8{instr[7]}}, instr[7:0]};
                jorB = 2'b10;
                memToReg = 1;
                writeReg = 4'b1111;
            end
            5'b00101: begin 
                readReg1 = {0, instr[10:8]};
                readReg2 = 4'b1111;
                ALUOp = 4'b0001;
                controlB = 2'b10;
                controlMem = 2'b11;
                ifJump = 0;
                immNum = {{8{instr[7]}}, instr[7:0]};
                jorB = 2'b11;
                memToReg = 1;
                writeReg = 4'b1111;
            end
            5'b00110: begin
                case(instr[1:0])
                    2'b00: begin 
                        readReg1 = {0, instr[7:5]}; 
                        readReg2 = 4'b1111;
                        ALUOp = 4'b0110;
                        controlB = 2'b01;
                        controlMem = 2'b11;
                        ifJump = 1;
                        if(instr[4:2]==0)   immNum = 8;
                        else                immNum = {{13{0}}, instr[4:2]};
                        jorB = 2'b11;
                        memToReg = 1;
                        writeReg = {0, instr[10:8]};      
                    end
                    2'b11: begin 
                        readReg1 = {0, instr[7:5]}; 
                        readReg2 = 4'b1111;
                        ALUOp = 4'b1000;
                        controlB = 2'b01;
                        controlMem = 2'b11;
                        ifJump = 1;
                        if(instr[4:2]==0)   immNum = 8;
                        else                immNum = {{13{0}}, instr[4:2]};
                        jorB = 2'b11;
                        memToReg = 1;
                        writeReg = {0, instr[10:8]};     
                    end
                    default: begin 
                        readReg1 = 4'b1111;         
                        readReg2 = 4'b1111;
                        ALUOp = 4'b0000;
                        controlB = 2'b10;
                        controlMem = 2'b11;
                        ifJump = 1;
                        immNum = 0;
                        jorB = 2'b11;
                        memToReg = 1;
                        writeReg = 4'b1111;        
                    end
                endcase
            end
            5'b01000: begin 
                readReg1 = {0, instr[10:8]};
                readReg2 = 4'b1111;
                ALUOp = 4'b0000;
                controlB = 2'b01;
                controlMem = 2'b11;
                ifJump = 1;
                immNum = {{12{instr[3]}}, instr[3:0]};
                jorB = 2'b11;
                memToReg = 1;
                writeReg = {0, instr[7:5]};
            end
            5'b01001: begin 
                readReg1 = {0, instr[10:8]};
                readReg2 = 4'b1111;
                ALUOp = 4'b0000;
                controlB = 2'b01;
                controlMem = 2'b11;
                ifJump = 1;
                immNum = {{8{instr[7]}}, instr[7:0]};
                jorB = 2'b11;
                memToReg = 1;
                writeReg = {0, instr[10:8]};
            end
            5'b01011: begin 
                readReg1 = {0, instr[10:8]};
                readReg2 = 4'b1111;
                ALUOp = 4'b1001;
                controlB = 2'b01;
                controlMem = 2'b11;
                ifJump = 1;
                immNum = {8'b00000000, instr[7:0]};
                jorB = 2'b11;
                memToReg = 1;
                writeReg = 4'b1001; //T
            end
            5'b01100: begin
                case(instr[10:8])
                    3'b011: begin 
                        readReg1 = 4'b1000; //SP    
                        readReg2 = 4'b1111;
                        ALUOp = 4'b0000;
                        controlB = 2'b01;
                        controlMem = 2'b11;
                        ifJump = 1;
                        immNum = {{8{instr[7]}}, instr[7:0]};
                        jorB = 2'b11;
                        memToReg = 1;
                        writeReg = 4'b1000; //SP       
                    end
                    3'b000: begin 
                        readReg1 = 4'b1001; //T     
                        readReg2 = 4'b1111;
                        ALUOp = 4'b0001;
                        controlB = 2'b10;
                        controlMem = 2'b11;
                        ifJump = 0;
                        immNum = {{8{instr[7]}}, instr[7:0]};
                        jorB = 2'b10;
                        memToReg = 1;
                        writeReg = 4'b1111;        
                    end
                    3'b100: begin 
                        readReg1 = {0, instr[7:5]}; 
                        readReg2 = 4'b1111;
                        ALUOp = 4'b0000;
                        controlB = 2'b10;
                        controlMem = 2'b11;
                        ifJump = 1;
                        immNum = 0;
                        jorB = 2'b11;
                        memToReg = 1;
                        writeReg = 4'b1000; //SP        
                    end
                    default: begin 
                        readReg1 = 4'b1111;         
                        readReg2 = 4'b1111;
                        ALUOp = 4'b0000;
                        controlB = 2'b10;
                        controlMem = 2'b11;
                        ifJump = 1;
                        immNum = 0;
                        jorB = 2'b11;
                        memToReg = 1;
                        writeReg = 4'b1111;        
                    end
                endcase
            end
            5'b01101: begin 
                readReg1 = 4'b1111;         
                readReg2 = 4'b1111;
                ALUOp = 4'b0000;
                controlB = 2'b01;
                controlMem = 2'b11;
                ifJump = 1;
                immNum = {8'b00000000, instr[7:0]};
                jorB = 2'b11;
                memToReg = 1;
                writeReg = {0, instr[10:8]};
            end
            5'b01111: begin 
                readReg1 = {0, instr[7:5]}; 
                readReg2 = 4'b1111;
                ALUOp = 4'b0000;
                controlB = 2'b00;
                controlMem = 2'b11;
                ifJump = 1;
                immNum = 0;
                jorB = 2'b11;
                memToReg = 1;
                writeReg = {0, instr[10:8]};
            end
            5'b10010: begin 
                readReg1 = 4'b1000; //SP    
                readReg2 = 4'b1111;
                ALUOp = 4'b0000;
                controlB = 2'b01;
                controlMem = 2'b01;
                ifJump = 1;
                immNum = {{8{instr[7]}}, instr[7:0]};
                jorB = 2'b11;
                memToReg = 0;
                writeReg = {0, instr[10:8]};
            end
            5'b10011: begin 
                readReg1 = {0, instr[10:8]};
                readReg2 = 4'b1111;
                ALUOp = 4'b0000;
                controlB = 2'b01;
                controlMem = 2'b01;
                ifJump = 1;
                immNum = {{11{instr[4]}}, instr[4:0]};
                jorB = 2'b11;
                memToReg = 0;
                writeReg = {0, instr[7:5]};
            end
            5'b11010: begin 
                readReg1 = 4'b1000; //SP    
                readReg2 = {0, instr[10:8]};
                ALUOp = 4'b0000;
                controlB = 2'b10;
                controlMem = 2'b10;
                ifJump = 1;
                immNum = {{8{instr[7]}}, instr[7:0]};
                jorB = 2'b11;
                memToReg = 1;
                writeReg = 4'b1111;
            end
            5'b11011: begin 
                readReg1 = {0, instr[10:8]};
                readReg2 = {0, instr[7:5]};
                ALUOp = 4'b0000;
                controlB = 2'b01;
                controlMem = 2'b10;
                ifJump = 1;
                immNum = {{11{instr[4]}}, instr[4:0]};
                jorB = 2'b11;
                memToReg = 1;
                writeReg = 4'b1111;
            end
            5'b11100: begin
                case(instr[1:0])
                    2'b01: begin 
                        readReg1 = {0, instr[10:8]};
                        readReg2 = {0, instr[7:5]};
                        ALUOp = 4'b0000;
                        controlB = 2'b00;
                        controlMem = 2'b11;
                        ifJump = 1;
                        immNum = 0;
                        jorB = 2'b11;
                        memToReg = 1;
                        writeReg = {0, instr[4:2]};       
                    end
                    2'b11: begin 
                        readReg1 = {0, instr[10:8]};
                        readReg2 = {0, instr[7:5]};
                        ALUOp = 4'b0001;
                        controlB = 2'b00;
                        controlMem = 2'b11;
                        ifJump = 1;
                        immNum = 0;
                        jorB = 2'b11;
                        memToReg = 1;
                        writeReg = {0, instr[4:2]};        
                    end
                    default: begin 
                        readReg1 = 4'b1111;         
                        readReg2 = 4'b1111;
                        ALUOp = 4'b0000;
                        controlB = 2'b10;
                        controlMem = 2'b11;
                        ifJump = 1;
                        immNum = 0;
                        jorB = 2'b11;
                        memToReg = 1;
                        writeReg = 4'b1111;        
                    end
                endcase
            end
            5'b11101: begin
                case(instr[4:0])
                    5'b00000: begin
                        case(instr[7:5])
                            3'b000: begin 
                                readReg1 = {0, instr[10:8]};
                                readReg2 = 4'b1111;
                                ALUOp = 4'b0000;
                                controlB = 2'b10;
                                controlMem = 2'b11;
                                ifJump = 0;
                                immNum = 0;
                                jorB = 2'b01;
                                memToReg = 1;
                                writeReg = 4'b1111;                
                            end
                            3'b010: begin 
                                readReg1 = 4'b1111;         
                                readReg2 = 4'b1111;
                                ALUOp = 4'b1011;
                                controlB = 2'b10;
                                controlMem = 2'b11;
                                ifJump = 1;
                                immNum = 0;
                                jorB = 2'b11;
                                memToReg = 1;
                                writeReg = {0, instr[10:8]};                
                            end
                            default: begin 
                                readReg1 = 4'b1111;         
                                readReg2 = 4'b1111;
                                ALUOp = 4'b0000;
                                controlB = 2'b10;
                                controlMem = 2'b11;
                                ifJump = 1;
                                immNum = 0;
                                jorB = 2'b11;
                                memToReg = 1;
                                writeReg = 4'b1111;                
                            end
                        endcase
                    end
                    5'b00010: begin 
                        readReg1 = {0, instr[10:8]};
                        readReg2 = {0, instr[7:5]};
                        ALUOp = 4'b1001;
                        controlB = 2'b00;
                        controlMem = 2'b11;
                        ifJump = 1;
                        immNum = 0;
                        jorB = 2'b11;
                        memToReg = 1;
                        writeReg = 4'b1001; //T       
                    end
                    5'b01010: begin 
                        readReg1 = {0, instr[10:8]};
                        readReg2 = {0, instr[7:5]};
                        ALUOp = 4'b1010;
                        controlB = 2'b00;
                        controlMem = 2'b11;
                        ifJump = 1;
                        immNum = 0;
                        jorB = 2'b11;
                        memToReg = 1;
                        writeReg = 4'b1001; //T        
                    end
                    5'b01011: begin 
                        readReg1 = {0, instr[7:5]}; 
                        readReg2 = 4'b1111;
                        ALUOp = 4'b0100;
                        controlB = 2'b00;
                        controlMem = 2'b11;
                        ifJump = 1;
                        immNum = 0;
                        jorB = 2'b11;
                        memToReg = 1;
                        writeReg = {0, instr[10:8]};        
                    end
                    5'b01100: begin 
                        readReg1 = {0, instr[10:8]};
                        readReg2 = {0, instr[7:5]};
                        ALUOp = 4'b0010;
                        controlB = 2'b00;
                        controlMem = 2'b11;
                        ifJump = 1;
                        immNum = 0;
                        jorB = 2'b11;
                        memToReg = 1;
                        writeReg = {0, instr[10:8]};        
                    end
                    5'b01101: begin 
                        readReg1 = {0, instr[10:8]};
                        readReg2 = {0, instr[7:5]};
                        ALUOp = 4'b0011;
                        controlB = 2'b00;
                        controlMem = 2'b11;
                        ifJump = 1;
                        immNum = 0;
                        jorB = 2'b11;
                        memToReg = 1;
                        writeReg = {0, instr[10:8]};       
                    end
                    5'b01111: begin 
                        readReg1 = {0, instr[7:5]}; 
                        readReg2 = 4'b1111;
                        ALUOp = 4'b0101;
                        controlB = 2'b10;
                        controlMem = 2'b11;
                        ifJump = 1;
                        immNum = 0;
                        jorB = 2'b11;
                        memToReg = 1;
                        writeReg = {0, instr[10:8]};       
                    end
                    default: begin 
                        readReg1 = 4'b1111;         
                        readReg2 = 4'b1111;
                        ALUOp = 4'b0000;
                        controlB = 2'b10;
                        controlMem = 2'b11;
                        ifJump = 1;
                        immNum = 0;
                        jorB = 2'b11;
                        memToReg = 1;
                        writeReg = 4'b1111;        
                    end
                endcase
            end
            5'b11110: begin
                case(instr[7:0])
                    8'b00000000: begin 
                        readReg1 = 4'b1010; //IH    
                        readReg2 = 4'b1111;
                        ALUOp = 4'b0000;
                        controlB = 2'b10;
                        controlMem = 2'b11;
                        ifJump = 1;
                        immNum = 0;
                        jorB = 2'b11;
                        memToReg = 1;
                        writeReg = {0, instr[10:8]};        
                    end
                    8'b00000001: begin 
                        readReg1 = {0, instr[10:8]};
                        readReg2 = 4'b1111;
                        ALUOp = 4'b0000;
                        controlB = 2'b10;
                        controlMem = 2'b11;
                        ifJump = 1;
                        immNum = 0;
                        jorB = 2'b11;
                        memToReg = 1;
                        writeReg = 4'b1010; //IH     
                    end
                    default: begin
                        readReg1 = 4'b1111;         
                        readReg2 = 4'b1111;
                        ALUOp = 4'b0000;
                        controlB = 2'b10;
                        controlMem = 2'b11;
                        ifJump = 1;
                        immNum = 0;
                        jorB = 2'b11;
                        memToReg = 1;
                        writeReg = 4'b1111;        
                    end
                endcase
            end
            default: begin 
                readReg1 = 4'b1111;         
                readReg2 = 4'b1111;
                ALUOp = 4'b0000;
                controlB = 2'b10;
                controlMem = 2'b11;
                ifJump = 1;
                immNum = 0;
                jorB = 2'b11;
                memToReg = 1;
                writeReg = 4'b1111;
            end
        endcase
    end

endmodule
