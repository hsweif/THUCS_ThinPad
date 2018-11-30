`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:14:20 11/30/2018 
// Design Name: 
// Module Name:    fenpin 
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
module fenpin(
    input clk,
    output reg clk_out
    );

reg [25:0] cnt = 26'b0;

always@(negedge clk) begin
	cnt <= cnt + 1;
	if (cnt == 26'b00000000000000000000000000) begin
		clk_out <= 0;
	end
	else if (cnt == 26'b01011011100011011000000000) begin
		clk_out <= 1;
		cnt <= 26'b0;
	end
end

endmodule
