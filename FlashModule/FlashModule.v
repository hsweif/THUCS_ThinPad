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
    // input [15:0] Address,
    input clk,
    input rst,
    // input [15:0] WriteData,
    inout [15:0] FlashData,
    output reg [7:0] ledA,
    output reg [7:0] ledB,
    output reg [23:0] FlashAddr,
    output reg FlashByte,
    output reg FlashVpen,
    output reg FlashCE,
    output reg FlashOE,
    output reg FlashWE,
    output reg FlashRP,
    output reg finish,
    // Ram1 data
    inout [15:0] Ram1Data,
	output reg [17:0] Ram1Addr,
	output reg Ram1OE,
    output reg Ram1WE,
    output reg Ram1EN,
    output reg rdn,
    output reg wrn
    );

`include "define.v"

integer status = 0;
reg link_flash = 0;
reg link_ram1 = 0;
reg check = 0;
reg eraseMode = 0;
reg [15:0] Address = 16'b0;
reg [15:0] flash_data = 16'b0;
reg [15:0] ram1_data = 16'b0;
reg [15:0] read_data = 16'b0;
assign FlashData[15:0] = link_flash ? flash_data : 16'bz; 
assign Ram1Data[15:0] = link_ram1 ? ram1_data : 16'bz;

always @(*) begin
    ledA[7:0] <= read_data[15:8];
    ledB[7:0] <= read_data[7:0];
end

always @(negedge rst or negedge clk) begin
    if(rst == 0) begin
        // TODO: Reset behavior in flash.
        status = 0;
		rdn <= 1;
		wrn <= 1;
		Ram1EN <= 1;
		Ram1OE <= 1;
		Ram1WE <= 1;
        Address <= 16'b0;
        finish <= 0;
    end
    else begin
    // Motivated by clk rather than rst
        if(status == 0) begin
            // Initial status 
            if(Address < `UPPER_BOUND) begin
                status = 1;
                finish <= 0;
            end
            else begin
                status = 0;
                finish <= 1;
            end
        end
        else if(status == 1) begin
            // read1, write op 0xFF
            link_flash <= 1;
            flash_data[15:0] <= `FLASH_READ_OP;
            FlashWE <= 0;
            status = status + 1;
        end
        else if(status == 2) begin
            // read2, prepare to read
            FlashWE <= 1;
            link_flash <= 0;
            status = status + 1;
        end
        else if(status == 3) begin
            // read3, setup the address
            FlashOE <= 0;
            FlashAddr[23:16] <= 8'b0;
            FlashAddr[15:0] <= Address;
            status = status + 1;
        end
        else if(status == 4)begin
            // read4, read the data from flash. 
            FlashOE <= 1;
            read_data[15:0] <= FlashData;
            // status = 0;
            status = status + 1;
        end
        else if(status == 5) begin
            Ram1Addr[17:16] <= 2'b0;
            Ram1Addr[15:0] <= Address;
            link_ram1 <= 1;
            Ram1EN <= 0;
            Ram1OE <= 1;
            Ram1WE <= 0;
            ram1_data[15:0] <= read_data;	
            status = status + 1;
        end
        else if(status == 6) begin
            Ram1EN <= 0;
            Ram1OE <= 1;
            Ram1WE <= 1;
            Address <= Address + 16'h0001;
            status = 0;
        end
        /*
        else if(status == 5) begin
            // erase1, write the erase op to flash data
            link_flash <= 1;
            FlashWE <= 0;
            status = status + 1;
        end
        else if(status == 6) begin
            // erase2, erase the memory
            FlashWE <= 1;
            flash_data[15:0] <= `FLASH_ERASE_OP;
            status = status + 1;
        end
        else if(status == 7) begin
            // erase3
            FlashWE <= 0;
            status = status + 1;
        end
        else if(status == 8) begin
            // erase4
            FlashAddr[23:16] <= 8'b0;
            FlashAddr[15:0] <= Address;
            flash_data[15:0] <= `FLASH_ERASE;
            status = status + 1;
        end
        else if(status == 9) begin
            // erase5, the data is erased
            FlashWE <= 1;
            status = status + 1;
        end
        else if(status == 10) begin
            // write1
            link_flash <= 4;
            if(eraseMode == 1) begin
                flash_data[15:0] <= `FLASH_ERASE_OP;
            end
            else begin
                // Write mode
                flash_data[15:0] <= `FLASH_WRITE_OP;
            end
            status = status + 1;
        end
        else if(status == 11) begin
            // write2
            FlashWE <= 1;
            status = status + 1;
        end
        else if(status == 12) begin
            // write3
            FlashWE <= 0;
            status = status + 1;
        end
        else if(status == 13) begin
            // write4
            FlashAddr[23:16] <= 8'b0;
            FlashAddr[15:0] <= Address;
            if(eraseMode == 1) begin
                flash_data[15:0] <= `FLASH_ERASE;
            end
            else begin
                flash_data[15:0] <= WriteData; 
            end
            status = status + 1;
        end
        else if(status == 14) begin
            // write5, write end
            FlashWE <= 1;
            status = status + 1;
        end
        else if(status == 15) begin
            // Write6
            FlashWE <= 0;
            flash_data[15:0] <= `FLASH_READREG_OP;
            status = status + 1;
        end
        else if(status == 16) begin
            // Write7
            FlashWE <= 0;
            status = status + 1;
        end
        else if(status == 17) begin
            FlashWE <= 1;
            status = status + 1;
        end
        else if(status == 18) begin
            link_flash <= 0;
            status = status + 1;
        end
        else if(status == 19) begin
            FlashOE <= 0;
            status = status + 1;
        end
        else if(status == 20) begin
            check <= FlashData[7];
            status = status + 1;
        end 
        else if(status == 21) begin
            if(check == 1) begin
                FlashOE <= 1;
                status = 0;
            end
            else begin
                status = 15; // Write 6
            end
        end
        else
            ;
        */
    end
end

endmodule
