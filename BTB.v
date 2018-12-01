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
integer i;
always @(posedge clk or negedge rst) begin  	//å†™è¡¨
	if (rst == 0) begin
		error <= 0;
		toPC[0] <= 1;
		toPC[1] <= 1;
		toPC[2] <= 1;
		toPC[3] <= 1;
		toPC[4] <= 1;
		toPC[5] <= 1;
		toPC[6] <= 1;
		toPC[7] <= 1;
		toPC[8] <= 1;
		toPC[9] <= 1;
		toPC[10] <= 1;
		toPC[11] <= 1;
		toPC[12] <= 1;
		toPC[13] <= 1;
		toPC[14] <= 1;
		toPC[15] <= 1;
	end
	else if (ifJump === 0) begin //å¦‚æžœæ˜¯è·³è½¬æŒ‡�
		if(toPC[(jFromPC>>2)%16] != jToPC) begin
			if(jToPC == jFromPC+4 && toPC[(jFromPC>>2)%16] == 1)
				error <= 0;
			else
				error <= 1;
			toPC[(jFromPC>>2)%16] <= jToPC;
		end
		else begin
			error <= 0;
		end
	end
	else begin
		error <= 0;
	end
end
always @(ifJump_id or curPC or rst) begin 	//curPCΪ��ǰPC��ϣ�����Ԥ��PCΪprePC
	if(rst == 0)  begin
		prePC = 0;
	end
	else if(ifJump_id === 0 && toPC[(curPC>>2)%16] != 1) //toPCΪԤ���
			prePC = toPC[(curPC>>2)%16];
	else 	prePC = curPC + 4;
end

endmodule
