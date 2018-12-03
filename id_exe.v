`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:44:43 11/25/2018 
// Design Name: 
// Module Name:    id_exe 
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
module id_exe(
	input rst,
    input clk,
    input idClear,
    input idKeep,
    input [15:0] rdata1_in,
    input [15:0] rdata2_in,
    input [15:0] imme_in,
    input [3:0] wreg_in,
    input [3:0] rreg1_in,
    input [3:0] rreg2_in,
    input [15:0] pc_in,
    input [3:0] aluop_in,
    input [1:0] controlb_in,
    input ifjump_in,
    input [1:0] jorb_in,
    input [1:0] controlmem_in,
    input controlwb_in,
    output reg [15:0] rdata1_out,
    output reg [15:0] rdata2_out,
    output reg [15:0] imme_out,
    output reg[3:0] wreg_out,
    output reg [3:0] rreg1_out,
    output reg [3:0] rreg2_out,
    output reg [15:0] pc_out,
    output reg [3:0] aluop_out,
    output reg [1:0] controlb_out,
    output reg ifjump_out,
    output reg [1:0] jorb_out,
    output reg [1:0] controlmem_out,
    output reg controlwb_out
    );

always @ (negedge rst or negedge clk) begin
    if (rst == 0) begin
			wreg_out <= 4'b1111;
			controlmem_out <= 4'b11;
			rreg1_out <= 4'b1111;
			rreg2_out <= 4'b1111;
			rdata1_out <= 16'b0000000000000000;
			rdata2_out <= 16'b0000000000000000;
			imme_out <= 16'b0000000000000000;
			aluop_out <= 4'b0001;
			controlb_out <= 2'b10;
			ifjump_out <= 1;
			jorb_out <= 2'b11;
			controlwb_out <= 1;
			pc_out <= 0;
	 end
	 else begin
	 	if(idKeep == 1) begin
	 		
	 	end
		else if(idClear != 1) begin//if(idClear !== 1) begin
			wreg_out <= wreg_in;
			controlmem_out <= controlmem_in;
			rreg1_out <= rreg1_in;
			rreg2_out <= rreg2_in;
			rdata1_out <= rdata1_in;
			rdata2_out <= rdata2_in;
			imme_out <= imme_in;
			aluop_out <= aluop_in;
			controlb_out <= controlb_in;
			ifjump_out <= ifjump_in;
			jorb_out <= jorb_in;
			controlwb_out <= controlwb_in;
			pc_out <= pc_in;
		end
		else begin
			wreg_out <= 4'b1111;
			controlmem_out <= 2'b11; 
			rreg1_out <= 4'b1111;
			rreg2_out <= 4'b1111;
			rdata1_out <= 16'b0000000000000000;
			rdata2_out <= 16'b0000000000000000;
			imme_out <= 16'b0000000000000000;
			aluop_out <= 4'b0001;
			controlb_out <= 2'b10;
			ifjump_out <= 1;
			jorb_out <= 2'b11;
			controlwb_out <= 1;
			pc_out <= 0;
		end
	 end
end
endmodule
