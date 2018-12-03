`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:21:54 11/25/2018 
// Design Name: 
// Module Name:    if_id 
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
module if_id(
output reg [7:0] ledA,
output reg [7:0] ledB,
	input clk,
	input rst,
	input ifkeep,
	input ifClear,
    input [15:0] pc_in,
    input [15:0] instr_in,
    output reg [15:0] pc_out,
    output reg [15:0] instr_out
    );
reg [7:0] cnt = 8'b0;
always @ (negedge rst or negedge clk) begin
	
	if (rst == 0) begin
		instr_out <= 16'b0000100000000000;
		pc_out <= 0;
		cnt <= 0;
	//ledB[7:0] <= instr_out[7:0];
	//ledA[7:0] <= instr_out[15:8];
	end
	else if(ifkeep == 1) begin //if(ifkeep === 1) begin
		//ledB[7:0] <= 8'b00000001;
	//.	ledA[7:0] <= instr_in[15:8];
		if (instr_out == 16'b0100111100000010)
			cnt <= cnt + 1;
	end
	else if(ifClear == 1) begin //else if(ifClear === 1) begin
		pc_out <= 0;
		instr_out <= 16'b0000100000000000;
		//if (instr_out == 16'b0100111100000010)
		//	cnt <= cnt + 1;
		//ledB[7:0] <= instr_out[7:0];
	//ledA[7:0] <= instr_out[15:8];
	end
	else begin
	pc_out <= pc_in + 1;
	instr_out <= instr_in;
	if (instr_in == 16'b0100111100000010)
		cnt <= cnt + 1;
	//ledB[7:0] <= instr_out[7:0];
	//ledA[7:0] <= instr_out[15:8];
	end
end
always@ (*)begin
ledA <= instr_out[15:8];
ledB <= pc_out[7:0];
end
endmodule
