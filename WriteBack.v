`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:26:27 11/24/2018 
// Design Name: 
// Module Name:    WriteBack 
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
module WriteBack(
    input clk,
    input [15:0] mem,
    input [15:0] alu,
    output [15:0] WriteBackData,
    input MemToReg
    );

assign WriteBackData=(MemToReg==0)?mem:alu;

endmodule
