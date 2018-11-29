`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:00:17 11/19/2018 
// Design Name: 
// Module Name:    DataMemory 
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
`include "define.v"

module DataMemory(
    input [15:0] Address,
    input [15:0] WriteData,
    input MemRead,
    input MemWrite,
    input tbre,
    input tsre,
	 input clk,
    input data_ready,
    inout [15:0] Ram1Data,
	 inout [15:0] Ram2Data,
	 output reg [15:0] ReadData,
	 output reg [15:0] RamAddr,
	 output reg AddressSrc, //0: Ram1 Address, 1: Ram2 Address
	 output reg Ram1OE,
    output reg Ram1WE,
    output reg Ram1EN,
	 output reg Ram2OE,
    output reg Ram2WE,
    output reg Ram2EN,
    output reg rdn,
    output reg wrn
    );

reg [15:0] ram1_data = 16'b0;
reg [15:0] ram2_data = 16'b0;
reg link_data1 = 1;
reg link_data2 = 1;
reg status = 0;
assign Ram1Data = link_data1 ? ram1_data : 16'bz;
assign Ram2Data = link_data2 ? ram2_data : 16'bz;

//clock fequency in memory reading is half main frequency.
always @(negedge clk)
begin
	rdn <= 1;
	wrn <= 1;
	if(status == 0)
	begin
		status <= 1;
		RamAddr[15:0] <= Address[15:0];
		if(Address < `RAM1_UPPER)
		begin
			AddressSrc <= 0;
			link_data2 <= 0;
			if(MemWrite == 1)
				link_data1 <= 0;
			else
				link_data1 <= 1;
		end
		else if(Address == `COM1_DATA || Address == `COM1_COMMAND) //Port 1
		begin
			// TODO: IO data to port 1
		end		
		else if(Address == `COM2_DATA || Address == `COM2_COMMAND) //Port 2
		begin
			// TODO: IO data to port 1
		end
		else
		begin
			AddressSrc <= 1;
			link_data1 <= 0;
			if(MemWrite == 1)
				link_data2 <= 1;
			else
				link_data2 <= 0;
		end
	end
	else
	begin
		status <= 0;
		if(MemRead == 1)
		begin
			if(AddressSrc == 0) //Address is from Ram1
			begin
				Ram1EN <= 0;
				Ram1OE <= 0;
				Ram1WE <= 1;
				// Ram2 is not available now
				Ram2EN <= 1;
				Ram2OE <= 1;
				Ram2WE <= 1;
				ReadData[15:0] <= Ram1Data[15:0];
			end
			else // Address is from Ram2
			begin
				Ram2EN <= 0;
				Ram2OE <= 0;
				Ram2WE <= 1;
				// Ram1 is not available now
				Ram1EN <= 1;
				Ram1OE <= 1;
				Ram1WE <= 1;
				ReadData[15:0] <= Ram2Data[15:0];
			end
		end
		else if(MemWrite == 1)
		begin
			if(AddressSrc == 0)
			begin
				Ram1EN <= 0;
				Ram1OE <= 1;
				Ram1WE <= 0;
				// Ram2 is not available now
				Ram2EN <= 1;
				Ram2OE <= 1;
				Ram2WE <= 1;
				ram1_data[15:0] <= WriteData[15:0];
			end
			else
			begin
				Ram1EN <= 1;
				Ram1OE <= 1;
				Ram1WE <= 1;
				// Ram1 is not available now
				Ram2EN <= 0;
				Ram2OE <= 1;
				Ram2WE <= 0;
				ram2_data[15:0] <= WriteData[15:0];
			end
		end
		else
			;
	end
end

endmodule
