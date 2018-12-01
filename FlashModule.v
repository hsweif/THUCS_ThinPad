`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:26:21 12/01/2018 
// Design Name: 
// Module Name:    FlashModule 
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
module FlashModule(
    input [15:0] Address,
    input clk,
    input rst,
    input [15:0] WriteData,
    inout [15:0] FlashData,
    output [23:0] FlashAddr,
    output [15:0] ReadData,
    output FlashByte,
    output FlashVpen,
    output FlashCE,
    output FlashOE,
    output FlashWE,
    output FlashRP
    );

`include "define.v"

reg [3:0] status = 4'h0;
reg link_flash = 0;
reg [15:0] flash_data = `ZERO;
assign FlashData[15:0] = link_flash ? flash_data : 16'bz; 
always @(negedge rst or negedge clk) begin
    status <= status + 4'h1;
    if(rst == 0) begin
        // TODO: Reset behavior in flash.
        status = 4'h0;
    end
    else begin
    // Motivated by clk rather than rst
        if(status == 4'h0) begin
            // Initial status 
        end
        else if(status == 4'h1) begin
            // read1, write op 0xFF
            link_flash <= 1;
            flash_data[15:0] <= `FLASH_READ_OP;
            FlashWE <= 0;
            status <= 4'h2;
        end
        else if(status == 4'h2) begin
            // read2, prepare to read
            FlashWE <= 1;
            link_flash <= 0;
            status <= 4'h3;
        end
        else if(status == 4'h3) begin
            // read3, setup the address
            FlashOE <= 0;
            FlashAddr[23:16] <= 8'b0;
            FlashAddr[15:0] <= Address;
            status <= 4'h4;
        end
        else if(status == 4'h4)begin
            // read4, read the data from flash. 
            FlashOE <= 1;
            ReadData[15:0] <= FlashData;
            status = 4'h0;
        end
        else if(status == 4'h5) begin
            // erase1, write the erase op to flash data
            link_flash <= 1;
            FlashWE <= 0;
            status <= 4'h6;
        end
        else if(status == 4'h6) begin
            // erase2, erase the memory
            FlashWE <= 1;
            flash_data[15:0] <= `FLASH_ERASE_OP;
            status <= 4'h7;
        end
        else if(status == 4'h7) begin
            // erase3
            FlashWE <= 0;
            status <= 4'h8;
        end
        else if(status == 4'h8) begin
            // erase4
            FlashAddr[23:16] <= 8'b0;
            FlashAddr[15:0] <= Address;
            flash_data[15:0] <= `FLASH_ERASE;
            status <= 4'h9;
        end
        else if(status == 4'h9) begin
            // erase5, the data is erased
            FlashWE <= 1;
            status <= 4'hA;
        end
        else if(status == 4'hA) begin
            // write1
            FlashWE <= 0;
            link_flash <= 1;
            status <= 4'hB;
        end
        else if(status == 4'hB) begin
            // write2, change to write mode.
            flash_data[15:0] <= `FLASH_WRITE_OP;
            FlashWE <= 1;
            status <= 4'hC;
        end
        else if(status == 4'hC) begin
            // write3, enable write
            FlashWE <= 0;
            link_flash <= 1;
            status <= 4'hD;
        end
        else if(status == 4'hD) begin
            // write4, set the addr and data
            FlashAddr[23:16] <= 8'b0;
            FlashAddr[15:0] <= Address;
            flash_data[15:0] <= WriteData; 
            status <= 4'hE;
        end
        else if(status == 4'hE) begin
            // write5, write end
            FlashWE <= 1;
            link_flash <= 0;
            status <= 4'h0;
        end
        else
            ;
    end
end

endmodule
