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
    input [10:0] row,
    input [10:0] col, 
    output reg color,
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

    reg[15:0] vgaReg [15:0];

    always @(writeBackReg or instr) begin
      ledA[7:0] = register[8][15:8];
      ledB[7:0] = register[8][7:0];
    end

    always @(row or col) begin
        if(row == 0 && col == 0) begin
            vgaReg[0] <= register[0]; 
            vgaReg[1] <= register[1]; 
            vgaReg[2] <= register[2]; 
            vgaReg[3] <= register[3]; 
            vgaReg[4] <= register[4]; 
            vgaReg[5] <= register[5]; 
            vgaReg[6] <= register[6]; 
            vgaReg[7] <= register[7]; 
            vgaReg[8] <= register[8]; 
            vgaReg[9] <= register[9]; 
            vgaReg[10] <= register[10]; 
        end /* else begin
            vgaReg[0] <= vgaReg[0]; 
            vgaReg[1] <= vgaReg[1]; 
            vgaReg[2] <= vgaReg[2]; 
            vgaReg[3] <= vgaReg[3]; 
            vgaReg[4] <= vgaReg[4]; 
            vgaReg[5] <= vgaReg[5]; 
            vgaReg[6] <= vgaReg[6]; 
            vgaReg[7] <= vgaReg[7]; 
            vgaReg[8] <= vgaReg[8]; 
            vgaReg[9] <= vgaReg[9]; 
            vgaReg[10] <= vgaReg[10]; 
        end */
    end



    reg [10:0] digit;
    reg [10:0] regIndex;
    reg [10:0] dx;
    reg [10:0] dy;
    always @(row or col) begin // 640 * 480  color: 0=black; 1=white Ã¦Â°Â´Ã¥Â¹Â³Ã¦â€“Â¹Ã¥Ââ€˜Ã¯Â2Ã¯Â¼â€ºÃ§Â«â€“Ã§â€ºÂ´Ã¦â€“Â¹Ã¥Ââ€˜Ã¯Â¼Å4
        if(col < 192 || col >= 640 || row < 64 || row >= 416)
            color = 0; //black
        else begin
            digit = (col-192)>>4;
            regIndex = (row-64)>>5;
            dx = col[3:0];
            dy = row[4:0];
            // if (regIndex == 0 && row > 200)
            //     regIndex = 8;
            // if (regIndex == 1 && row > 200)
            //     regIndex = 9;
            // if (regIndex == 2 && row > 200)
            //     regIndex = 10;
            case(digit)
                0: begin
                    case(regIndex)
                        0: begin
                            if( (dx>1&&dx<14&&((dy>18&&dy<21)||(dy>7&&dy<10))) || (dy>7&&((dx>1&&dx<4)||(dx>11&&dx<14&&dy<21))) || (dx>3&&dx<14&&dy>20&&dy-dx>16&&dy-dx<20))
                                color = 1;
                            else 
                                color = 0;
                        end
                        1: begin
                            if( (dx>1&&dx<14&&((dy>18&&dy<21)||(dy>7&&dy<10))) || (dy>7&&((dx>1&&dx<4)||(dx>11&&dx<14&&dy<21))) || (dx>3&&dx<14&&dy>20&&dy-dx>16&&dy-dx<20))
                                color = 1;
                            else 
                                color = 0;
                        end
                        2: begin
                            if( (dx>1&&dx<14&&((dy>18&&dy<21)||(dy>7&&dy<10))) || (dy>7&&((dx>1&&dx<4)||(dx>11&&dx<14&&dy<21))) || (dx>3&&dx<14&&dy>20&&dy-dx>16&&dy-dx<20))
                                color = 1;
                            else 
                                color = 0;
                        end
                        3: begin
                            if( (dx>1&&dx<14&&((dy>18&&dy<21)||(dy>7&&dy<10))) || (dy>7&&((dx>1&&dx<4)||(dx>11&&dx<14&&dy<21))) || (dx>3&&dx<14&&dy>20&&dy-dx>16&&dy-dx<20))
                                color = 1;
                            else 
                                color = 0;
                        end
                        4: begin
                            if( (dx>1&&dx<14&&((dy>18&&dy<21)||(dy>7&&dy<10))) || (dy>7&&((dx>1&&dx<4)||(dx>11&&dx<14&&dy<21))) || (dx>3&&dx<14&&dy>20&&dy-dx>16&&dy-dx<20))
                                color = 1;
                            else 
                                color = 0;
                        end
                        5: begin
                            if( (dx>1&&dx<14&&((dy>18&&dy<21)||(dy>7&&dy<10))) || (dy>7&&((dx>1&&dx<4)||(dx>11&&dx<14&&dy<21))) || (dx>3&&dx<14&&dy>20&&dy-dx>16&&dy-dx<20))
                                color = 1;
                            else 
                                color = 0;
                        end
                        6: begin
                            if( (dx>1&&dx<14&&((dy>18&&dy<21)||(dy>7&&dy<10))) || (dy>7&&((dx>1&&dx<4)||(dx>11&&dx<14&&dy<21))) || (dx>3&&dx<14&&dy>20&&dy-dx>16&&dy-dx<20))
                                color = 1;
                            else 
                                color = 0;
                        end
                        7: begin
                            if( (dx>1&&dx<14&&((dy>18&&dy<21)||(dy>7&&dy<10))) || (dy>7&&((dx>1&&dx<4)||(dx>11&&dx<14&&dy<21))) || (dx>3&&dx<14&&dy>20&&dy-dx>16&&dy-dx<20))
                                color = 1;
                            else 
                                color = 0;
                        end
                        8: begin // S
                            if( (dx>1&&dx<14&&(dy>29||(dy>7&&dy<10)||(dy>18&&dy<21))) || (dy>7&&dy<21&&dx>1&&dx<4) || (dy>18&&dx>11&&dx<14) )
                                color = 1;
                            else 
                                color = 0;
                        end
                        9: begin // 
                            color = 0;
                        end
                        10: begin
                            if(((dy>27||(dy>7&&dy<10))&&dx>1&&dx<14) || (dx>5&&dx<10&&dy>7))
										  color = 1;
									 else
										  color = 0;
                        end
                    endcase
                end
                1: begin
                    case(regIndex)
                        0: begin // 0
                            if((dx > 1 && dx < 14 && (dy > 29 || (dy > 7 && dy < 10))) || (dy > 7 && ((dx > 1 && dx < 4) || (dx > 11 && dx < 14))))
                                color = 1;
                            else 
                                color = 0;
                        end
                        1: begin // 1
                            if((dy > 27 && dx > 1 && dx < 14) || (dx > 5 && dx < 10 && dy > 7) || (dx > 1 && dx < 6 && dy > 8 && dy < 13 && (dy + dx > 13)))
										 color = 1;
									else
										 color = 0;
                        end
                        2: begin // 2
                            if( (dx>1&&dx<14&&(dy>29||(dy>7&&dy<10)||(dy>18&&dy<21))) || (dy>18&&dx>1&&dx<4) || (dy>7&&dy<21&&dx>11&&dx<14) )
                                color = 1;
                            else 
                                color = 0; 
                        end
                        3: begin // 3
                            if( (dx>1&&dx<14&&(dy>29||(dy>7&&dy<10)||(dy>18&&dy<21)))  || (dy>7&&dx>11&&dx<14) )
                                color = 1;
                            else 
                                color = 0;
                        end
                        4: begin // 4
                            if( (dx>1&&dx<14&&dy>18&&dy<21)  || (dy>7&&((dx>11&&dx<14)||(dx>1&&dx<4&&dy<21))) )
                                color = 1;
                            else 
                                color = 0;
                        end
                        5: begin // 5
                            if( (dx>1&&dx<14&&(dy>29||(dy>7&&dy<10)||(dy>18&&dy<21))) || (dy>7&&dy<21&&dx>1&&dx<4) || (dy>18&&dx>11&&dx<14) )
                                color = 1;
                            else 
                                color = 0;
                        end
                        6: begin // 6
                            if( (dx>1&&dx<14&&(dy>29||(dy>7&&dy<10)||(dy>18&&dy<21))) || (dy>7&&dx>1&&dx<4) || (dy>18&&dx>11&&dx<14) )
                                color = 1;
                            else 
                                color = 0;
                        end
                        7: begin // 7
                            if( (dx>1&&dx<14&&dy>7&&dy<10) || (dy>7&&dx>11&&dx<14) )
                                color = 1;
                            else 
                                color = 0;
                        end
                        8: begin // P
                            if( (dx>1&&dx<14&&((dy>7&&dy<10)||(dy>18&&dy<21))) || (dy>7&&dx>1&&dx<4) || (dy>7&&dy<21&&dx>11&&dx<14) )
                                color = 1;
                            else 
                                color = 0;
                        end
                        9: begin // T
                            if( (dx>1&&dx<14&&dy>7&&dy<10) || (dy>7&&dx>6&&dx<9) )
                                color = 1;
                            else 
                                color = 0;
                        end
                        10: begin // H
                            if( (dx>1&&dx<14&&dy>18&&dy<21) || (dy>7&&dx>1&&dx<4) || (dy>7&&dx>11&&dx<14) )
                                color = 1;
                            else 
                                color = 0;
                        end
                    endcase
                end
                2: begin // =
                    if( dx>1&&dx<14&&((dy>14&&dy<17)||(dy>22&&dy<25)) )
                        color = 1;
                    else 
                        color = 0;
                end
                3: begin
                    if((vgaReg[regIndex[3:0]]>>15)&1 == 1) begin
                        if((dy > 27 && dx > 1 && dx < 14) || (dx > 5 && dx < 10 && dy > 7) || (dx > 1 && dx < 6 && dy > 8 && dy < 13 && (dy + dx > 13)))
                            color = 1;
                        else
                            color = 0;
                    end else begin
                        if((dx > 1 && dx < 14 && (dy > 29 || (dy > 7 && dy < 10))) || (dy > 7 && ((dx > 1 && dx < 4) || (dx > 11 && dx < 14))))
                            color = 1;
                        else 
                            color = 0;
                    end
                end
                4: begin
                    if((vgaReg[regIndex[3:0]]>>14)&1 == 1) begin
                        if((dy > 27 && dx > 1 && dx < 14) || (dx > 5 && dx < 10 && dy > 7) || (dx > 1 && dx < 6 && dy > 8 && dy < 13 && (dy + dx > 13)))
                            color = 1;
                        else
                            color = 0;
                    end else begin
                        if((dx > 1 && dx < 14 && (dy > 29 || (dy > 7 && dy < 10))) || (dy > 7 && ((dx > 1 && dx < 4) || (dx > 11 && dx < 14))))
                            color = 1;
                        else 
                            color = 0;
                    end
                end
                5: begin
                    if((vgaReg[regIndex[3:0]]>>13)&1 == 1) begin
                        if((dy > 27 && dx > 1 && dx < 14) || (dx > 5 && dx < 10 && dy > 7) || (dx > 1 && dx < 6 && dy > 8 && dy < 13 && (dy + dx > 13)))
                            color = 1;
                        else
                            color = 0;
                    end else begin
                        if((dx > 1 && dx < 14 && (dy > 29 || (dy > 7 && dy < 10))) || (dy > 7 && ((dx > 1 && dx < 4) || (dx > 11 && dx < 14))))
                            color = 1;
                        else 
                            color = 0;
                    end
                end
                6: begin
                    if((vgaReg[regIndex[3:0]]>>12)&1 == 1) begin
                        if((dy > 27 && dx > 1 && dx < 14) || (dx > 5 && dx < 10 && dy > 7) || (dx > 1 && dx < 6 && dy > 8 && dy < 13 && (dy + dx > 13)))
                            color = 1;
                        else
                            color = 0;
                    end else begin
                        if((dx > 1 && dx < 14 && (dy > 29 || (dy > 7 && dy < 10))) || (dy > 7 && ((dx > 1 && dx < 4) || (dx > 11 && dx < 14))))
                            color = 1;
                        else 
                            color = 0;
                    end
                end
                7: begin
                    if((vgaReg[regIndex[3:0]]>>11)&1 == 1) begin
                        if((dy > 27 && dx > 1 && dx < 14) || (dx > 5 && dx < 10 && dy > 7) || (dx > 1 && dx < 6 && dy > 8 && dy < 13 && (dy + dx > 13)))
                            color = 1;
                        else
                            color = 0;
                    end else begin
                        if((dx > 1 && dx < 14 && (dy > 29 || (dy > 7 && dy < 10))) || (dy > 7 && ((dx > 1 && dx < 4) || (dx > 11 && dx < 14))))
                            color = 1;
                        else 
                            color = 0;
                    end
                end
                8: begin
                   if((vgaReg[regIndex[3:0]]>>10)&1 == 1) begin
                        if((dy > 27 && dx > 1 && dx < 14) || (dx > 5 && dx < 10 && dy > 7) || (dx > 1 && dx < 6 && dy > 8 && dy < 13 && (dy + dx > 13)))
                            color = 1;
                        else
                            color = 0;
                    end else begin
                        if((dx > 1 && dx < 14 && (dy > 29 || (dy > 7 && dy < 10))) || (dy > 7 && ((dx > 1 && dx < 4) || (dx > 11 && dx < 14))))
                            color = 1;
                        else 
                            color = 0;
                    end 
                end
                9: begin
                    if((vgaReg[regIndex[3:0]]>>9)&1 == 1) begin
                        if((dy > 27 && dx > 1 && dx < 14) || (dx > 5 && dx < 10 && dy > 7) || (dx > 1 && dx < 6 && dy > 8 && dy < 13 && (dy + dx > 13)))
                            color = 1;
                        else
                            color = 0;
                    end else begin
                        if((dx > 1 && dx < 14 && (dy > 29 || (dy > 7 && dy < 10))) || (dy > 7 && ((dx > 1 && dx < 4) || (dx > 11 && dx < 14))))
                            color = 1;
                        else 
                            color = 0;
                    end
                end
                10: begin
                    if((vgaReg[regIndex[3:0]]>>8)&1 == 1) begin
                        if((dy > 27 && dx > 1 && dx < 14) || (dx > 5 && dx < 10 && dy > 7) || (dx > 1 && dx < 6 && dy > 8 && dy < 13 && (dy + dx > 13)))
                            color = 1;
                        else
                            color = 0;
                    end else begin
                        if((dx > 1 && dx < 14 && (dy > 29 || (dy > 7 && dy < 10))) || (dy > 7 && ((dx > 1 && dx < 4) || (dx > 11 && dx < 14))))
                            color = 1;
                        else 
                            color = 0;
                    end
                end
                11: begin
                    if((vgaReg[regIndex[3:0]]>>7)&1 == 1) begin
                        if((dy > 27 && dx > 1 && dx < 14) || (dx > 5 && dx < 10 && dy > 7) || (dx > 1 && dx < 6 && dy > 8 && dy < 13 && (dy + dx > 13)))
                            color = 1;
                        else
                            color = 0;
                    end else begin
                        if((dx > 1 && dx < 14 && (dy > 29 || (dy > 7 && dy < 10))) || (dy > 7 && ((dx > 1 && dx < 4) || (dx > 11 && dx < 14))))
                            color = 1;
                        else 
                            color = 0;
                    end
                end
                12: begin
                    if((vgaReg[regIndex[3:0]]>>6)&1 == 1) begin
                        if((dy > 27 && dx > 1 && dx < 14) || (dx > 5 && dx < 10 && dy > 7) || (dx > 1 && dx < 6 && dy > 8 && dy < 13 && (dy + dx > 13)))
                            color = 1;
                        else
                            color = 0;
                    end else begin
                        if((dx > 1 && dx < 14 && (dy > 29 || (dy > 7 && dy < 10))) || (dy > 7 && ((dx > 1 && dx < 4) || (dx > 11 && dx < 14))))
                            color = 1;
                        else 
                            color = 0;
                    end
                end
                13: begin
                    if((vgaReg[regIndex[3:0]]>>5)&1 == 1) begin
                        if((dy > 27 && dx > 1 && dx < 14) || (dx > 5 && dx < 10 && dy > 7) || (dx > 1 && dx < 6 && dy > 8 && dy < 13 && (dy + dx > 13)))
                            color = 1;
                        else
                            color = 0;
                    end else begin
                        if((dx > 1 && dx < 14 && (dy > 29 || (dy > 7 && dy < 10))) || (dy > 7 && ((dx > 1 && dx < 4) || (dx > 11 && dx < 14))))
                            color = 1;
                        else 
                            color = 0;
                    end
                end
                14: begin
                    if((vgaReg[regIndex[3:0]]>>4)&1 == 1) begin
                        if((dy > 27 && dx > 1 && dx < 14) || (dx > 5 && dx < 10 && dy > 7) || (dx > 1 && dx < 6 && dy > 8 && dy < 13 && (dy + dx > 13)))
                            color = 1;
                        else
                            color = 0;
                    end else begin
                        if((dx > 1 && dx < 14 && (dy > 29 || (dy > 7 && dy < 10))) || (dy > 7 && ((dx > 1 && dx < 4) || (dx > 11 && dx < 14))))
                            color = 1;
                        else 
                            color = 0;
                    end
                end
                15: begin
                   if((vgaReg[regIndex[3:0]]>>3)&1 == 1) begin
                        if((dy > 27 && dx > 1 && dx < 14) || (dx > 5 && dx < 10 && dy > 7) || (dx > 1 && dx < 6 && dy > 8 && dy < 13 && (dy + dx > 13)))
                            color = 1;
                        else
                            color = 0;
                    end else begin
                        if((dx > 1 && dx < 14 && (dy > 29 || (dy > 7 && dy < 10))) || (dy > 7 && ((dx > 1 && dx < 4) || (dx > 11 && dx < 14))))
                            color = 1;
                        else 
                            color = 0;
                    end 
                end
                16: begin
                    if((vgaReg[regIndex[3:0]]>>2)&1 == 1) begin
                        if((dy > 27 && dx > 1 && dx < 14) || (dx > 5 && dx < 10 && dy > 7) || (dx > 1 && dx < 6 && dy > 8 && dy < 13 && (dy + dx > 13)))
                            color = 1;
                        else
                            color = 0;
                    end else begin
                        if((dx > 1 && dx < 14 && (dy > 29 || (dy > 7 && dy < 10))) || (dy > 7 && ((dx > 1 && dx < 4) || (dx > 11 && dx < 14))))
                            color = 1;
                        else 
                            color = 0;
                    end
                end
                17: begin
                    if((vgaReg[regIndex[3:0]]>>1)&1 == 1) begin
                        if((dy > 27 && dx > 1 && dx < 14) || (dx > 5 && dx < 10 && dy > 7) || (dx > 1 && dx < 6 && dy > 8 && dy < 13 && (dy + dx > 13)))
                            color = 1;
                        else
                            color = 0;
                    end else begin
                        if((dx > 1 && dx < 14 && (dy > 29 || (dy > 7 && dy < 10))) || (dy > 7 && ((dx > 1 && dx < 4) || (dx > 11 && dx < 14))))
                            color = 1;
                        else 
                            color = 0;
                    end
                end
                18: begin
                    if((vgaReg[regIndex[3:0]])&1 == 1) begin
                        if((dy > 27 && dx > 1 && dx < 14) || (dx > 5 && dx < 10 && dy > 7) || (dx > 1 && dx < 6 && dy > 8 && dy < 13 && (dy + dx > 13)))
                            color = 1;
                        else
                            color = 0;
                    end else begin
                        if((dx > 1 && dx < 14 && (dy > 29 || (dy > 7 && dy < 10))) || (dy > 7 && ((dx > 1 && dx < 4) || (dx > 11 && dx < 14))))
                            color = 1;
                        else 
                            color = 0;
                    end
                end                                                                              
            endcase
            // if((vgaReg[regIndex]>>(15-digit))&1 == 1) begin //Ã¦â€°â€œÃ¥â€¡ÂÃ¥Â¯Â¹Ã¥Âºâ€Ã§Å¡â€žÃ¨Â¯Â¥Ã¥Â¤â€žÃ§Å¡â€žcolor
            //      if((dy > 27 && dx > 1 && dx < 14) || (dx > 5 && dx < 10 && dy > 7) || (dx > 1 && dx < 6 && dy > 8 && dy < 13 && (dy + dx > 13)))
            //           color = 1;
            //      else
            //           color = 0;
            // end
            // else begin //Ã¦â€°â€œÃ¥â€¡ÂÃ¥Â¯Â¹Ã¥Âºâ€Ã§Å¡â€žÃ¨Â¯Â¥Ã¥Â¤â€žÃ§Å¡â€žcolor
            //      if((dx > 1 && dx < 14 && (dy > 29 || (dy > 7 && dy < 10))) || (dy > 7 && ((dx > 1 && dx < 4) || (dx > 11 && dx < 14))))
            //           color = 1;
            //      else 
            //           color = 0;
            // end
        end
    end

    always @(negedge clk or negedge rst) begin      
        if(rst == 0) begin
            register[0] <= 16'b0000000000000000;
            register[1] <= 16'b0000000000000000;
            register[2] <= 16'b0000000000000000;
            register[3] <= 16'b0000000000000000;
            register[4] <= 16'b0000000000000000;
            register[5] <= 16'b0000000000000000;
            register[6] <= 16'b0000000000000000;
            register[7] <= 16'b0000000000000000;
            register[8] <= 16'b0000000000000000;
            register[9] <= 16'b0000000000000000;
            register[10] <= 16'b0000000000000000;
            register[11] <= 16'b0000000000000000;
            register[12] <= 16'b0000000000000000;
            register[13] <= 16'b0000000000000000;
            register[14] <= 16'b0000000000000000;
            register[15] <= 16'b0000000000000000;
        end
        else if(writeBackReg != 15)begin
            register[writeBackReg] <= writeBackData;
        end
          else begin
                register[15] <= 16'b0000000000000000;
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
