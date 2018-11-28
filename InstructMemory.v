`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:07:12 11/28/2018 
// Design Name: 
// Module Name:    InstructMemory 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: This is real instruction memory
//
//////////////////////////////////////////////////////////////////////////////////
module InstructMemory(
	 input clk,
    input rst,
	 input MemConflict,
    input [15:0] sw,
    input [15:0] pc,
	 inout [15:0] Ram1Data, //Read from the main bus.
	 output reg [17:0] Ram1Addr,
	 output reg [15:0] Instruct,
    output reg Ram1OE,
    output reg Ram1WE,
    output reg Ram1EN
    );

reg status = 0;
reg linkData = 1;
reg [15:0] ramData = 16'b0;
assign Ram1Data = linkData ? ramData : 16'bz;

`define NOP_INSTRUCT 16'b0000100000000000

always @(negedge clk or negedge rst)
begin
	if(rst == 0) begin
		// Do something?
	end
	else if(status == 0) begin
		status <= 1;
		if(MemConflict == 1) begin
			Instruct[15:0] <= `NOP_INSTRUCT;
		end
		else begin
			linkData <= 0; // Before read from the bug, we need to set it to z. No write in this module.
			Ram1EN <= 0;
			Ram1OE <= 0;
			Ram1WE <= 1;
			Ram1Addr[17:16] <= 2'b00;
			Ram1Addr[15:0] <= pc;
		end
	end
	else if(status == 1) begin
		status <= 0;
		if(MemConflict == 1) begin
			Instruct[15:0] <= `NOP_INSTRUCT;
		end
		else begin
			Instruct <= Ram1Data;
		end
	end
	else
		;
end

endmodule
