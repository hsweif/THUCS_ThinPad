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

/*always @ (negedge clk) begin
	if (rst == 1)
		AddedPC <= origin;
	else
		AddedPC <= pc + 4'h4;
end

always @ (*) begin
	if (rst == 1) begin
		pc = origin;
	end
	else begin
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
end*/

// always @ (*) begin
//  	AddedPC = pc + 4'h4;
// end

always @ (negedge clk or posedge rst) begin
	if (rst == 1)
		pc <= origin;
	else begin
		if (PCKeep === 1) begin
		end
		else if(ifJump === 0 && error == 1) begin 
			pc <= newPC; //预测错误，恢复
		end
		else
		begin
			pc <= prePC;
		end
	end
end

endmodule

