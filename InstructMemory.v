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
`include "define.v"
module InstructMemory(
	 input clk,
    input rst,
	 input MemRead,
	 input MemWrite,
    input [15:0] pc,
	 input [15:0] DM_Address,
	 inout [15:0] Ram1Data, //Read from the main bus.
	 output reg [17:0] Ram1Addr,
	 output reg [15:0] Instruct,
	 output reg MemConflict,
    output reg Ram1OE,
    output reg Ram1WE,
    output reg Ram1EN
    );

reg status = 0;
reg linkData = 1;
reg [15:0] ramData = 16'b0;
assign Ram1Data = linkData ? ramData : 16'bz;

function Ram1Conflict;
input _MemRead, _MemWrite, _ram1Address;
begin
	if((_MemRead | _MemWrite) == 1)begin
		if(_ram1Address < `RAM1_UPPER)begin
			Ram1Conflict = 1;
		end
		else if(_ram1Address == `COM1_DATA || _ram1Address == `COM1_COMMAND)begin
			Ram1Conflict = 1;
		end
		else if(_ram1Address == `COM2_DATA || _ram1Address == `COM2_COMMAND)begin
			Ram1Conflict = 1;
		end
		else begin
			Ram1Conflict = 0;
		end
	end
	else begin
		Ram1Conflict = 0;
	end
end
endfunction

wire conflict;
assign conflict = Ram1Conflict(MemRead, MemWrite, DM_Address);

always @(negedge clk or negedge rst)
begin
	if(rst == 0) begin
		// Do something?
	end
	else if(status == 0) begin
		status <= 1;
		if(conflict == 1) begin
			MemConflict <= 1;
			Instruct[15:0] <= `NOP_INSTRUCT;
		end
		else begin
			linkData <= 0; // Before read from the bug, we need to set it to z. No write in this module.
			Ram1EN <= 0;
			Ram1OE <= 0;
			Ram1WE <= 1;
			Ram1Addr[17:16] <= 2'b00;
			Ram1Addr[15:0] <= pc;
			MemConflict <= 0;
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
