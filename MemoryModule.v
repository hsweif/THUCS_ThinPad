`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:21:14 11/28/2018 
// Design Name: 
// Module Name:    MemoryModule 
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
module MemoryModule(
	 input clk,
    input rst,
    input [15:0] pc,
    input [15:0] Address,
    input MemRead,
    input MemWrite,
    input data_ready,
	 output reg [15:0] instruct,
    inout [15:0] Ram1Data,
	 inout [15:0] Ram2Data,
	 output reg [15:0] ReadData,
	 output MemConflict,
	 inout [15:0] Ram1Data, //Read from the main bus.
	 output reg [15:0] Instruct
    );


endmodule
