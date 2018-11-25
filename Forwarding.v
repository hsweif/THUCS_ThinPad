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
	 input [1:0] MemControl,
	 output reg [1:0] Forward,
	 output reg [1:0] ForwardingA,
	 output reg [1:0] ForwardingB
    );

reg MemWrite = 0;

always @ (*) begin
	if (MemControl == 2'b10) begin
		MemWrite = 1;
	end
	else
		MemWrite = 0;
	ForwardingA = 2'b00;
	ForwardingB = 2'b00;
	Forward = 2'b00;
	if (MemWrite == 0) begin
		if (WRegFW1 != 4'b1111) begin
			if (WRegFW1 == R1) begin
				ForwardingA = 2'b01;
			end
			if (WRegFW1 == R2) begin
				ForwardingB = 2'b01;
			end
		end
		if (WRegFW2 != 4'b1111) begin
			if ((WRegFW2 == R1) && (WRegFW2 != WRegFW1)) begin
				ForwardingA = 2'b10;
			end
			if ((WRegFW2 == R2) && (WRegFW2 != WRegFW1)) begin
				ForwardingB = 2'b10;
			end
		end
	end
	else begin
		if (WRegFW1 != 4'b1111) begin
			if (WRegFW1 == R1) begin
				ForwardingA = 2'b01;
			end
			if (WRegFW1 == R2) begin
				Forward = 2'b01;
			end
		end
		if (WRegFW2 != 4'b1111) begin
			if ((WRegFW2 == R1) && (WRegFW2 != WRegFW1)) begin
				ForwardingA = 2'b10;
			end
			if ((WRegFW2 == R2) && (WRegFW2 != WRegFW1)) begin
				Forward = 2'b10;
			end
		end
	end
end

endmodule
