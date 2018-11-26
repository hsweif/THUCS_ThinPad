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

reg[15:0] fakeMemPool[0:255];
reg[15:0] content = 16'b0;
integer pos = 0;

always @(posedge clk or posedge rst)
begin
	if(rst == 1)
		$readmemb("FakeMemPool.mem", fakeMemPool);
	else
	begin
		if(MemRead == 1)
			ReadData[15:0] <= fakeMemPool[pos];
		else if(MemWrite == 1)
			fakeMemPool[pos] = WriteData;
		else
			;
		AddressSrc <= 1; // Fake condition: All in ram2.
	end
end

always @(*)
begin
	if(255 > (Address >> 2))
		pos = Address >> 2;
	else
		;
end
endmodule
