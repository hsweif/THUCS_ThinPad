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

module MemoryModule(
//output reg [7:0] ledA,
	//output reg [7:0] ledB,
	 input clk,
	 input rst,
	 // Used for instruction module
    // input [15:0] pc,
	 output reg MemConflict,
	 // Used for memory conflict
    input [15:0] Address,
    input [15:0] WriteData,
    input MemRead,
    input MemWrite,
	 output reg [15:0] ReadData,
	 // output reg [15:0] Instruct,
	 // Used for RAM1, in both instruction and data module 
    inout [15:0] Ram1Data,
	 output reg [17:0] Ram1Addr,
	 output reg Ram1OE,
    output reg Ram1WE,
    output reg Ram1EN,
	 // Used for RAM2, in data module 
	 inout [15:0] Ram2Data,
	 output reg [17:0] Ram2Addr,
	 output reg Ram2OE,
    output reg Ram2WE,
    output reg Ram2EN,
	 // UART control signal
    output reg noStop,
	 input tbre,
    input tsre,
    output reg rdn,
    output reg wrn
    );
// This function is used to detect ram1 conflict.
function Ram1Conflict;
input _MemRead, _MemWrite, _ram1Address;
begin

	if((_MemRead | _MemWrite) == 1)begin

		if(_ram1Address < `RAM1_UPPER)begin
			Ram1Conflict = 1;
		end
		else if(_ram1Address == `COM1_DATA || _ram1Address == `COM1_COMMAND)begin
			Ram1Conflict = 1;
		end
		else if(_ram1Address == `COM2_DATA || _ram1Address == `COM2_COMMAND)begin
			Ram1Conflict = 1;
		end
		else begin
			Ram1Conflict = 0;
		end
	end
	else begin
		Ram1Conflict = 0;
	end
	
	//Ram1Conflict = 0;
end
endfunction

function IsUartPort;
input _address;
begin
	if(`COM1_DATA <= _address && _address <= `COM2_COMMAND)
		IsUartPort = 1;
	else
		IsUartPort = 0;
end
endfunction

reg [15:0] ram1_data = 16'b0;
reg [15:0] ram2_data = 16'b0;
reg link_data1 = 1;
reg link_data2 = 1;
reg status = 0;
wire conflict;
wire isUart;
assign isUart = IsUartPort(Address);
assign conflict = Ram1Conflict(MemRead, MemWrite, Address);
assign Ram1Data[15:0] = link_data1 ? ram1_data : 16'bz;
assign Ram2Data[15:0] = link_data2 ? ram2_data : 16'bz;

/*always@(*) begin 
ledA[4] <= MemWrite;
ledA[3] <= MemRead;
if (MemRead == 1)begin
ledB[7:0] = ReadData[7:0];
end
else if (MemWrite == 1)
begin
ledB[7:0] = WriteData[7:0];
end
else
;
end*/

//clock fequency in memory reading is half main frequency.
always @(negedge clk or negedge rst)
begin
	/*if(MemWrite == 1) begin
		ledB[7] <= 1'b1;
		ledA[7] <= 1'b1;
	end
	if(MemRead == 1) begin
		ledB[7] <= 1'b1;
		ledB[6] <= 1'b1;
	end*/
	if(rst == 0) begin
		// TODO: What does reset mean in ram module?
		status <= 0;
		rdn <= 1;
		wrn <= 1;
		Ram1EN <= 1;
		Ram1OE <= 1;
		Ram1WE <= 1;
		Ram2EN <= 1;
		Ram2OE <= 1;
		Ram2WE <= 1;
		Ram1Addr <= 18'b0;
		Ram2Addr <= 18'b0;
		ram1_data <= 16'b0;
		ram2_data <= 16'b0;
	end
	else begin

	// sensitive to clk signal.
		Ram1Addr[17:16] <= 2'b0;
		Ram2Addr[17:16] <= 2'b0;
		if(status == 0) begin
			if(isUart) begin
				noStop <= 0;  
			end			
			else begin
				noStop <= 1;  
			end
			//ledA[6] <= 1;
			// Instruction Module
			/*if(conflict) begin
				MemConflict <= 1;
				Instruct[15:0] <= `NOP_INSTRUCT;
			end
			else begin
				link_data1 <= 0; // Before read from the bus, we need to set it to z
				Ram1EN <= 0;
				Ram1OE <= 0;
				Ram1WE <= 1;
				Ram1Addr[17:16] <= 2'b00;
				Ram1Addr[15:0] <= pc;
				MemConflict <= 0;
			end*/

			// Data Memory module
			if(Address < `RAM1_UPPER) begin
				rdn <= 1;
				wrn <= 1;
				// Ram2 is not available now
				Ram2EN <= 1;
				Ram2OE <= 1;
				Ram2WE <= 1;
				link_data2 <= 0;
				if(MemWrite == 1) begin
					Ram1Addr[15:0] <= Address;
					link_data1 <= 1;
					Ram1EN <= 0;
					Ram1OE <= 1;
					Ram1WE <= 0;
					ram1_data[15:0] <= WriteData;	
					status <= 1;					
				end
				else if(MemRead == 1) begin
					Ram1Addr[15:0] <= Address;
					link_data1 <= 0;
					Ram1EN <= 0;
					Ram1OE <= 0;
					Ram1WE <= 1;
					status <= 1;
				end
				else begin
					Ram1EN <= 1;
					Ram1OE <= 1;
					Ram1WE <= 1;
				end
			end
			else begin
				// Ram1 is not available now
				Ram1EN <= 1;
				Ram1OE <= 1;
				Ram1WE <= 1;
				if(Address == `COM1_DATA || Address == `COM1_COMMAND) begin
					// TODO: IO data to port 1
					if(MemRead == 1) begin
					 	wrn <= 1;
						rdn <= 1;
						link_data1 <= 0;
						status <= 1;
					end
					else if(MemWrite == 1) begin
					 	wrn <= 0;
						rdn <= 1;
						link_data1 <= 1;
						status <= 1;
					end
					else begin
						wrn <= 1;
						rdn <= 1;
					end
				end		
				else if(Address == `COM2_DATA || Address == `COM2_COMMAND) begin
					// TODO: IO data to port 2
				end
				else begin
				// Ram2
					rdn <= 1;
					wrn <= 1;
					link_data1 <= 0;
					if(MemWrite == 1) begin
						link_data2 <= 1;
						Ram2Addr[15:0] <= Address;
						Ram2EN <= 0;
						Ram2OE <= 1;
						Ram2WE <= 0;
						ram2_data[15:0] <= WriteData;
						status <= 1;
					end
					else if(MemRead == 1) begin
						link_data2 <= 0; // Before read, the bus need to be set to zz
						Ram2Addr[15:0] <= Address;
						Ram2EN <= 0;
						Ram2OE <= 0;
						Ram2WE <= 1;
						status <= 1;
					end
					else begin
						Ram2EN <= 1;
						Ram2OE <= 1;
						Ram2WE <= 1;
					end
				end
			end
		end
		else if(status == 1) begin
			// status == 1
			if(isUart) begin
				noStop <= 0;  
			end			
			else begin
				status <= 0;
				noStop <= 1;  
			end
			// Instruction Module
			/*if(MemConflict == 1) begin
				Instruct[15:0] <= `NOP_INSTRUCT;
			end
			else begin
				Instruct[15:0] <= Ram1Data;
			end*/

			// Data memory module.
			if(Address < `RAM1_UPPER) begin
				rdn <= 1;
				wrn <= 1;
				// Ram2 is not available now
				Ram2EN <= 1;
				Ram2OE <= 1;
				Ram2WE <= 1;
				if(MemRead == 1) begin
					Ram1EN <= 0;
					Ram1OE <= 0;
					Ram1WE <= 1;
					ReadData[15:0] <= Ram1Data;
				end
				else if(MemWrite == 1) begin
					//ledA[1] <= 1;
					Ram1EN <= 0;
					Ram1OE <= 1;
					Ram1WE <= 1;
				end
				else begin
			//	ledA[1] <= 0;
					Ram1EN <= 1;
					Ram1OE <= 1;
					Ram1WE <= 1;
				end
			end
			else  begin // Ram2
				// Ram1 is not available now
				//ledA[5] <= 0;
				Ram1EN <= 1;
				Ram1OE <= 1;
				Ram1WE <= 1;
				if(Address == `COM1_DATA || Address == `COM1_COMMAND) begin
					// TODO: IO data to port 1
					if(MemRead == 1) begin
						// FIXME: Check if rdn <= 1 and read in same edge is ok or not.
					 	wrn <= 1;
						rdn <= 0;
						link_data1 <= 0;
						status <= 2;
					end
					else if(MemWrite == 1) begin
					 	wrn <= 1;
						rdn <= 1;
						link_data1 <= 1;
						ram1_data[7:0] <= WriteData[7:0]; 
					end
					else
						;
				end		
				else if(Address == `COM2_DATA || Address == `COM2_COMMAND) begin
					// TODO: IO data to port 2
				end
				else begin
				// Normal Ram2 Address
					rdn <= 1;
					wrn <= 1;
					if(MemWrite == 1) begin
						Ram2EN <= 0;
						Ram2OE <= 1;
						Ram2WE <= 1;
					end
					else if(MemRead == 1) begin
						Ram2EN <= 0;
						Ram2OE <= 0;
						Ram2WE <= 1;
						ReadData[15:0] <= Ram2Data;
					end
					else begin
						Ram2EN <= 1;
						Ram2OE <= 1;
						Ram2WE <= 1;
					end
				end
			end
		end
		else if(status == 2)begin
			if(isUart) begin
				if(Address == `COM1_DATA || Address == `COM1_COMMAND) begin
					// Just a bubble here.
				end
				else begin
				end
				status <= 3;
				noStop <= 0;
			end			
			else begin
				noStop <= 1;
				status <= 0;
			end
		end
		else if(status == 3)begin
			if(isUart) begin
				if(Address == `COM1_DATA || Address == `COM1_COMMAND) begin
					rdn <= 1;
					ReadData[7:0] <= Ram1Data[7:0];
					ReadData[15:8] <= 8'b0;
				end
				else begin
				end
				noStop <= 1;
				status <= 0;
			end			
			else begin
				noStop <= 1;
				status <= 0;
			end
		end
	end
end

endmodule
