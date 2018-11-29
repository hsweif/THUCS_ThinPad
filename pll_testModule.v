`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:07:05 11/28/2018 
// Design Name: 
// Module Name:    pll_testModule 
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
pll_controller instance_name (
    .CLKIN_IN(CLKIN_IN), 
    .RST_IN(RST_IN), 
    .CLKIN_IBUFG_OUT(CLKIN_IBUFG_OUT), 
    .CLK0_OUT(CLK0_OUT), 
    .CLK2X_OUT(CLK2X_OUT), 
    .LOCKED_OUT(LOCKED_OUT)
    );
