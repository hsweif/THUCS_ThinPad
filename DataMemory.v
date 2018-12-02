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
output reg [7:0] ledA,
output reg [7:0] ledB,
	 input clk,
	 input rst,
	 // Used for instruction module
     input [15:0] pc,
	 output reg MemConflict,
	 // Used for memory conflict
    input [15:0] Address,
    input [15:0] WriteData,
    input MemRead,
    input MemWrite,
	 output reg [15:0] ReadData,
	 output reg [15:0] Instruct,
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
	 input data_ready,
    output reg noStop,
	 input tbre,
    input tsre,
    output reg rdn,
    output reg wrn
    );

reg [15:0] ram1_data = 16'b0;
reg [15:0] ram2_data = 16'b0;
reg link_data1 = 1;
reg link_data2 = 1;
integer status = 0;
reg isUart = 0;
assign Ram1Data[15:0] = link_data1 ? ram1_data : 16'bz;
assign Ram2Data[15:0] = link_data2 ? ram2_data : 16'bz;
always @(*) begin
	/*ledA[7] <= MemRead;
	ledA[6] <= MemWrite;
	ledA[5] <= MemConflict;
	ledA[4] <= clk;
	ledA[3:0] <= pc[3:0];*/
	ledA[7:0] <= Instruct[15:8];
	ledB[7:0] <= Instruct[7:0];
	// To detect ram1 conflict.
	if(MemRead == 1|| MemWrite == 1) begin
		if(Address < `RAM1_UPPER) begin
			MemConflict <= 1;
			isUart <= 0;
		end
		else if(Address == `COM1_DATA || Address == `COM1_COMMAND)begin
			MemConflict <= 1;
			isUart <= 1;
		end
		else if(Address == `COM2_DATA || Address == `COM2_COMMAND)begin
			MemConflict <= 1;
			isUart <= 1;
		end
		else begin
			MemConflict <= 0;
			isUart <= 0;
		end
	end
	else begin
		MemConflict <= 0;
		isUart <= 0;
	end
end

//clock fequency in memory reading is half main frequency.
always @(negedge clk or negedge rst)
begin
	if(rst == 0) begin
		status <= 0;
		noStop <= 1;
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
			if(isUart == 1) begin
				noStop <= 0;  
			end			
			else begin
				noStop <= 1;  
			end
			//ledA[6] <= 1;
			// Instruction Module
			if(MemConflict == 1) begin
				Instruct[15:0] <= `NOP_INSTRUCT;
			end
			else begin
				rdn <= 1;
				wrn <= 1;
				link_data1 <= 0; // Before read from the bus, we need to set it to z
				Ram1EN <= 0;
				Ram1OE <= 0;
				Ram1WE <= 1;
				Ram1Addr[17:16] <= 2'b00;
				Ram1Addr[15:0] <= pc;
				// FIXME: Be careful
				status <= 1;
			end

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
					// Do nothing.
				end
			end
			else begin
				// Ram1 is not available now
				if(isUart == 1) begin
					// TODO: IO data to port 1
					if(MemRead == 1) begin
					 	wrn <= 1;
						rdn <= 1;
						link_data1 <= 0;
						status <= 1;
					end
					else if(MemWrite == 1) begin
					// Write reset status
					 	wrn <= 1;
						rdn <= 1;
						link_data1 <= 1;
						// ram1_data[7:0] <= WriteData[7:0];
						status <= 1;
					end
					else begin
						wrn <= 1;
						rdn <= 1;
					end
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
						// FIXME: Be careful
						Ram2EN <= 1;
						Ram2OE <= 1;
						Ram2WE <= 1;
					end
				end
			end
		end
		else if(status == 1) begin
			// status == 1
			if(isUart == 1) begin
				noStop <= 0;  
			end			
			else begin
				status <= 0;
				noStop <= 1;  
			end
			// Instruction Module
			if(MemConflict == 1) begin
				Instruct[15:0] <= `NOP_INSTRUCT;
			end
			else begin
				rdn <= 1;
				wrn <= 1;
				Ram1EN <= 0;
				Ram1OE <= 0;
				Ram1WE <= 1;
				Instruct[15:0] <= Ram1Data;
			end
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
					Ram1EN <= 0;
					Ram1OE <= 1;
					Ram1WE <= 1;
				end
				else begin
					// Do nothing
				end
			end
			else  begin // Ram2
				if(isUart == 1) begin
					if(MemRead == 1) begin
					 	wrn <= 1;
						link_data1 <= 0;
						if(data_ready == 1) begin
							status <= 2;
							rdn <= 0;
						end
						else begin
							status <= 0;
							rdn <= 1;
						end
					end
					else if(MemWrite == 1) begin
					 	wrn <= 0;
						rdn <= 1;
						link_data1 <= 1;
						ram1_data[7:0] <= WriteData[7:0];
						status <= 2;
					end
					else
						;
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
			if(isUart == 1) begin
				if(MemRead == 1) begin
					rdn <= 1;
					ReadData[7:0] <= Ram1Data[7:0];
					ReadData[15:8] <= 8'b0;
					// noStop <= 1;
					// status <= 0;
					noStop <= 0;
					status <= 3;
				end
				else if(MemWrite == 1) begin
					wrn <= 1;
					rdn <= 1;
					link_data1 <= 1;
					noStop <= 0;
					if(tbre == 1)
						status <= 3;
					else
						status <= 2;
				end
			end
			else begin
				noStop <= 1;
				status <= 0;
			end
		end
		else if(status == 3) begin
			if(isUart == 1) begin
				if(MemWrite == 1) begin
					wrn <= 1;
					rdn <= 1;
					if(tsre == 1) begin
						status <= 0;
						noStop <= 1;
					end
					else begin
						status <= 3;
						noStop <= 0;
					end
				end
				else begin
					noStop <= 1;
					status <= 0;
				end
			end
			else begin
				noStop <= 1;
				status <= 0;
			end
		end
	end
end

endmodule
