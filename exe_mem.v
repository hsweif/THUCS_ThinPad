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

always @ (negedge clk) begin 
	memread_out <= controlmem_in[0];
	memwrite_out <= controlmem_in[1];
	controlwb_out <= controlwb_in;
	alu_out <= alu_in;
	wdata_out <= wdata_in;
	wreg_out <= wreg_in;
end

endmodule
