`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:23:01 11/24/2018 
// Design Name: 
// Module Name:    FakeDM 
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
module FakeDM(
    input [15:0] Address,
    input [15:0] WriteData,
    input MemRead,
    input MemWrite,
	 input rst,
	 input clk,
	 output reg [15:0] ReadData,
	 output reg AddressSrc //0: Ram1 Address, 1: Ram2 Address
    );

reg[15:0] fakeMemPool[0:31];
reg[15:0] content = 16'b0;
integer pos = 0;

always @(posedge clk or negedge rst)
begin
	if(rst == 0) begin
		fakeMemPool[0]  <= 16'b1111111111111111;
		fakeMemPool[1]  <= 16'b1111111111111110;
		fakeMemPool[2]  <= 16'b1111111111111100;
		fakeMemPool[3]  <= 16'b1111111111111000;
		fakeMemPool[4]  <= 16'b1111111111110000;
		fakeMemPool[5]  <= 16'b1111111111100000;
		fakeMemPool[6]  <= 16'b1111111111000000;
		fakeMemPool[7]  <= 16'b1111111110000000;
		fakeMemPool[8]  <= 16'b1111111100000000;
		fakeMemPool[9]  <= 16'b1111111000000000;
		fakeMemPool[10] <= 16'b1111110000000000;
		fakeMemPool[11] <= 16'b1111100000000000;
		fakeMemPool[12] <= 16'b1111000000000000;
		fakeMemPool[13] <= 16'b1110000000000000;
		fakeMemPool[14] <= 16'b1100000000000000;
		fakeMemPool[15] <= 16'b1000000000000000;
		fakeMemPool[16] <= 16'b0000000000000000;
		fakeMemPool[17] <= 16'b0000000000000000;
		fakeMemPool[18] <= 16'b0000000000000000;
		fakeMemPool[19] <= 16'b0000000000000000;
		fakeMemPool[20] <= 16'b0000000000000000;
		fakeMemPool[21] <= 16'b0000000000000000;
		fakeMemPool[22] <= 16'b0000000000000000;
		fakeMemPool[23] <= 16'b0000000000000000;
		fakeMemPool[24] <= 16'b0000000000000000;
		fakeMemPool[25] <= 16'b0000000000000000;
		fakeMemPool[26] <= 16'b0000000000000000;
		fakeMemPool[27] <= 16'b0000000000000000;
		fakeMemPool[28] <= 16'b0000000000000000;
		fakeMemPool[29] <= 16'b0000000000000000;
		fakeMemPool[30] <= 16'b0000000000000000;
		fakeMemPool[31] <= 16'b0000000000000000;
	end
	else
	begin
		if(MemRead == 1)
			ReadData[15:0] <= fakeMemPool[pos];
		else if(MemWrite == 1)
			fakeMemPool[pos] <= WriteData;
		else
			;
		AddressSrc <= 1; // Fake condition: All in ram2.
	end
end

always @(*)
begin
	if(32 > (Address >> 2))
		pos = Address >> 2;
	else
		;
end
endmodule
