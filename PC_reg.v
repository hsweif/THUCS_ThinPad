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
	 input error,
	 input [15:0] prePC,
	 output reg [15:0] pc
    );

reg [15:0] origin = 16'b0;

always @ (negedge clk or negedge rst) begin
	if (rst == 0)
		pc <= origin;
	else begin
		if (PCKeep == 1) begin//if (PCKeep === 1) begin
		end
		else if(ifJump == 0 && error == 1) begin //else if(ifJump === 0 && error == 1) begin 
			pc <= newPC; //预测错误，恢�
		end
		else
		begin
			pc <= prePC;
		end
	end
end

endmodule

