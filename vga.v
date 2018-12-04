`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:14:00 12/04/2018 
// Design Name: 
// Module Name:    vga 
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
module vga(
    input clk,
    input rst,
	 input [15:0] R0,
	 input [15:0] R1,
	 input [15:0] R2,
	 input [15:0] R3,
	 input [15:0] R4,
	 input [15:0] R5,
	 input [15:0] R6,
	 input [15:0] R7,
	 input [15:0] R8,
	 input [15:0] R9,
	 input [15:0] R10,
    output reg [2:0] R,
    output reg [2:0] G,
    output reg [2:0] B,
    output Hs,
    output Vs
    );

reg color;
reg [10:0] row;
reg [10:0] col;

assign Hs = ((col > 655) && (row < 753)) ? 0 : 1;
assign Vs = ((row > 489) && (row < 492)) ? 0 : 1;

reg [4:0] digit;
reg [4:0] regIndex;
reg [4:0] dx;
reg [5:0] dy;
reg[15:0] register [15:0];
always @(row or col) begin // 640 * 480  color: 0=black; 1=white æ°´å¹³æ–¹å‘ï�2ï¼›ç«–ç›´æ–¹å‘ï¼�4
  if(col < 192 || col >= 448 || row < 64 || row >= 416)
		color = 0; //black
  else begin
		dx = col[3:0];
		dy = row[4:0];
		digit = (col-192)>>4;
		regIndex = (row-64)>>5;
		if (regIndex == 0 && row > 200)
			regIndex = 8;
		if (regIndex == 1 && row > 200)
			regIndex = 9;
		if (regIndex == 2 && row > 200)
			regIndex = 10;
		if((register[regIndex]>>digit)&1 == 1) begin //æ‰“å‡�å¯¹åº”çš„è¯¥å¤„çš„color
			 if((dy > 27 && dx > 1 && dx < 14) || (dx > 5 && dx < 10 && dy > 7) || (dx > 1 && dx < 6 && dy > 8 && dy < 13 && (dy + dx > 13)))
				  color = 1;
			 else
				  color = 0;
		end
		else begin //æ‰“å‡�å¯¹åº”çš„è¯¥å¤„çš„color
			 if((dx > 1 && dx < 14 && (dy > 29 || (dy > 7 && dy < 10))) || (dy > 7 && ((dx > 1 && dx < 4) || (dx > 11 && dx < 14))))
				  color = 1;
			 else 
				  color = 0;
		end
  end
end


always @ (negedge clk or negedge rst) begin
	if (rst == 0) begin
		row <= 0;
		col <= 0;
	end
	else begin
		if (col == 799) begin
			if (row == 524) begin
				row <= 0;
			end
			else begin
				row <= row + 1;
			end
			col <= 0;
		end
		else begin
			col <= col + 1;
		end
		if (col == 0 && row == 0) begin
			register[0] <= R0;
			register[1] <= R1;
			register[2] <= R2;
			register[3] <= R3;
			register[4] <= R4;
			register[5] <= R5;
			register[6] <= R6;
			register[7] <= R7;
			register[8] <= R8;
			register[9] <= R9;
			register[10] <= R10;
		end
	end
end

always @ (*) begin
	if (color == 1) begin
		R = 3'b111;
		G = 3'b111;
		B = 3'b111;
	end
	else begin
		R = 3'b000;
		G = 3'b000;
		B = 3'b000;
	end
end

endmodule
