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
    output [15:0] pc,
	 output [15:0] AddedPC
    );

reg [15:0] origin = 16'b0;

always @ (posedge rst) begin
	begin
		pc <= origin;
	end
end

always @ (*) begin
	AddedPC = pc + 4'h4;
end

always @ (posedge clk) begin
	if (PCKeep == 1) begin
		;
	end 
	else 
	begin
		pc <= AddedPC;
	end
end

endmodule

