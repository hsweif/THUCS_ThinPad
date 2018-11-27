`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:33:39 11/24/2018 
// Design Name: 
// Module Name:    PC_reg 
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
module PC_reg(
    input PCKeep,
    input clk,
	input rst,
	input [15:0] newPC,
	input ifJump,
    output reg [15:0] pc,
	output reg [15:0] AddedPC
    );

reg [15:0] origin = 16'b0;

always @ (negedge rst) begin
	begin
		pc <= origin;
		AddedPC <= origin;
	end
end

always @ (*) begin
	if (PCKeep === 1) begin
		pc = AddedPC - 4;
	end 
	else if(ifJump == 0) begin
		pc = (newPC >> 2) << 2;
	end
	else
	begin
		pc = AddedPC;
	end
end

always @ (negedge clk) begin	
	AddedPC <= pc + 4'h4;
end

// always @ (*) begin
// 	AddedPC = pc + 4'h4;
// end

// always @ (negedge clk) begin
// 	if (PCKeep === 1) begin
// 		pc <= pc;
// 	end 
// 	else if(ifJump == 0) begin
// 		pc <= newPC;
// 	end
// 	else
// 	begin
// 		pc <= AddedPC;
// 	end
// end

endmodule

