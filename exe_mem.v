`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:57:30 11/25/2018 
// Design Name: 
// Module Name:    exe_mem 
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
module exe_mem(
input rst,
	 input clk,
	 input [1:0] controlmem_in,
	 input controlwb_in,
	 input [15:0] alu_in,
	 input [15:0] wdata_in,
	 input [3:0] wreg_in,
	 output reg memwrite_out,
	 output reg memread_out,
	 output reg controlwb_out,
	 output reg [15:0] alu_out,
	 output reg [15:0] wdata_out,
	 output reg [3:0] wreg_out
    );

always @ (negedge rst or negedge clk) begin
if (rst == 0) begin
	memwrite_out <= 0;
	memread_out <= 0;
	wreg_out <= 4'b1111;
	alu_out <= 16'b0;//000000000011111;
end 
else begin
	if (controlmem_in == 2'b01) begin
		memwrite_out <= 0;
		memread_out <= 1;
	end
	else if (controlmem_in == 2'b10) begin
		memwrite_out <= 1;
		memread_out <= 0;
	end
	else 
	begin
		memwrite_out <= 0;
		memread_out <= 0;
	end
	controlwb_out <= controlwb_in;
	alu_out <= alu_in;
	wdata_out <= wdata_in;
	wreg_out <= wreg_in;
	end
end

endmodule
