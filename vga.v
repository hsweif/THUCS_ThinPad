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
    input color,
    output reg [10:0] col,
    output reg [10:0] row,
    output reg [2:0] R,
    output reg [2:0] G,
    output reg [2:0] B,
    output Hs,
    output Vs
    );

assign Hs = ((col > 655) && (row < 753)) ? 0 : 1;
assign Vs = ((row > 489) && (row < 492)) ? 0 : 1;


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
