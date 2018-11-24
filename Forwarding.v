`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:36:29 11/24/2018 
// Design Name: 
// Module Name:    Forwarding 
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
module Forwarding(
	 input rst,
	 input [3:0] WRegFW1,
    input [3:0] WRegFW2,
	 input [3:0] R1,
    input [3:0] R2,
	 input [15:0] RData1,
    input [15:0] RData2,
	 output [1:0] Forward,
	 output [1:0] ForwardingA,
	 output [1:0] ForwardingB
    );

assign Forward = 2'b0;
assign ForwardingA = 2'b0;
assign ForwardingB = 2'b0;

endmodule
