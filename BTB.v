`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:04:56 11/28/2018 
// Design Name: 
// Module Name:    BTB 
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
module BTB(
	input rst,
	input clk,
	input [15:0] curPC,
	output reg [15:0] prePC,
	input ifJump_id,

	input [15:0] jFromPC,	//å®žé™…ä¸ºè·³è½¬æŒ‡ä»¤çš„ä¸‹ä¸€è·
	input [15:0] jToPC,		//è·³è½¬åˆ°çš„åœ°å€	
	input ifJump,
	output reg error
    );

reg [15:0] toPC [15:0];		//value
integer origin = 1;
integer i;
integer j;
always @(posedge clk or posedge rst) begin  	//å†™è¡¨
	if (rst == 1) begin
		error <= 0;
		for(i = 0; i < 16; i=i+1) begin
			toPC[i] <= origin;
		end
	end
	else if (ifJump === 0) begin //å¦‚æžœæ˜¯è·³è½¬æŒ‡ä»
		if(toPC[(jFromPC>>2)%16] !== jToPC) begin
			error <= 1;
			// toPC[1] <= 3;
			toPC[(jFromPC>>2)%16] <= jToPC;
		end
		else begin
			error <= 0;
			// toPC[1] <= 2;
		end
	end
	else begin
		// toPC[1] <= 4;
		error <= 2;
	end
end

always @(*) begin 	//æŸ¥è¡¨ï¼ŒèŽ·å¾—ä¸‹ä¸€è·³åœ°å€
	if(ifJump_id == 0 && toPC[((curPC-4)>>2)%16] != origin) //curPC为延时槽的PC
			prePC = toPC[((curPC-4)>>2)%16];
	else 	prePC = curPC + 4;
	i = ((curPC-4)>>2)%16;
end

endmodule
