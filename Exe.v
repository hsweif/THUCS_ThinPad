`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:38:13 11/18/2018 
// Design Name: 
// Module Name:    Exe 
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
module Exe(
    input [15:0] RData1,
    input [15:0] RData2,
    input [15:0] Imme,
    output reg [15:0] WData,
    input [15:0] PCSrc,
    input [3:0] ALUOp,
    input [1:0] ControlB,//00 01 10 11
    output reg [15:0] ALURes,
    output reg [15:0] NewPC,
	input [1:0] JorB,
	input [15:0] ALUBack,
	input [15:0] WriteBackData,
	input [1:0] Forward,
	input [1:0] ForwardingA,
	input [1:0] ForwardingB
);

reg [15:0] B0 = 16'b0;
reg [15:0] A = 16'b0;
reg [15:0] B = 16'b0;
reg [15:0] ShiftImme = 16'b0;
reg [15:0] CalPC = 16'b0;

always @(*)//mux1
begin
	case(ControlB)
		2'b00: B0 = RData2;
		2'b01: B0 = Imme;
		default: B0 = 16'b0;
	endcase
end

always @(*)//muxA
begin
	case(ForwardingA)
		2'b00: A = RData1;
		2'b01: A = ALUBack;
		2'b10: A = WriteBackData;
		default: A = 0;
	endcase
end

always @(*)//muxB
begin
	case(ForwardingB)
		2'b00: B = B0;
		2'b01: B = ALUBack;
		2'b10: B = WriteBackData;
		default: B = 0;
	endcase
end

always @(*)//mux2
begin
	case(Forward)
		2'b00: WData = RData2;
		2'b01: WData = ALUBack;
		2'b10: WData = WriteBackData;
		default: WData = 0;
	endcase
end

always @(*)//shiftleft
begin
	ShiftImme = Imme;
end

always @(*)//PCAdder
begin
	CalPC = PCSrc + ShiftImme;
end

always @(*)//ALU
begin
	case(ALUOp)
		4'b0000: ALURes = A + B;		
		4'b0001: ALURes = A - B;
		4'b0010: ALURes = A & B;
		4'b0011: ALURes = A | B;
		4'b0100: ALURes = 0 - A;
		4'b0101: ALURes = ~A;
		4'b0110: ALURes = A << B;
		4'b0111: ALURes = A >> B;
		4'b1000: ALURes = A >>> B;
		4'b1001: ALURes = (A < B) ? 1 : 0;
		4'b1010: ALURes = (A == B) ? 0 : 1;
		4'b1011: ALURes = PCSrc;
		default: ALURes = 0;
	endcase
end

//00:B 01:J 10:B== 11£ºB£¡=
always @(*)//mux3
begin
	case(JorB)
		2'b00: NewPC = CalPC;
		2'b01: NewPC = A;
		2'b10: NewPC = (A == 0) ? CalPC : (PCSrc+1);
		2'b11: NewPC = (A == 0) ? (PCSrc+1) : CalPC;
	endcase
end

endmodule
