`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:49:08 11/25/2018
// Design Name:   PipeLine
// Module Name:   C:/Users/jyx/Desktop/learn/Code/git/THUCS_ThinPad/testPipeLine.v
// Project Name:  ThinPad
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PipeLine
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testPipeLine;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [15:0] led;

	// Instantiate the Unit Under Test (UUT)
	PipeLine uut (
		.clk(clk), 
		.rst(rst), 
		.led(led)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#20;
		clk = 1;
		rst = 1;
		#20;
		clk = 0;
		#20;
		rst = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
		#20;
		clk = 1;
		#20;
		clk = 0;
        
		// Add stimulus here

	end
      
endmodule

