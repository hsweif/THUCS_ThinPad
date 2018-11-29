`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:59:57 11/24/2018 
// Design Name: 
// Module Name:    PipeLine 
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
module PipeLine(
	input clk, // TODO: need to be checked
	input rst,
	output [7:0] ledA,
	output [7:0] ledB,
	output reg ram1_oe,
	output reg ram1_en,
	output reg ram1_we,
	output reg ram2_oe,
	output reg ram2_en,
	output reg ram2_we,
	inout [15:0] ram1_data,
	inout [15:0] ram2_data,
	output reg [17:0] ram1_addr,
	output reg [17:0] ram2_addr,
	// data_ready,
	input tbre,
	input tsre,
	output reg rdn,
	output reg wrn
    );

// output and input for PLL
wire clk2x;
wire CLKIN_IBUFG_OUT;
wire CLK0_OUT;  
wire LOCKED_OUT;


// output and input of IF
wire [15:0] pc;
wire [15:0] addedPc;
wire [15:0] instruction;

// output and input of Instruction Memory
wire mem_conflict;

// output and input of ID
wire [15:0] idPC;
wire [15:0] idInstruction;
wire [3:0] ALUOp;
wire [1:0] controlB;
wire [1:0] controlMem;
wire ifJump;
wire [15:0] immNum;
wire [1:0] jorB;
wire memToReg;
wire [3:0] readReg1;
wire [3:0] writeReg;
wire [3:0] readReg2;
wire [15:0] readData1;
wire [15:0] readData2;

// output and input of Exe
wire [15:0] exe_rdata1;
wire [15:0] exe_rdata2;
wire [15:0] exe_imme;
wire [3:0] exe_wreg;
wire [3:0] exe_rreg1;
wire [3:0] exe_rreg2;
wire [15:0] exe_pc;
wire [3:0] exe_aluop;
wire [1:0] exe_controlb;
wire exe_ifjump;
wire [1:0] exe_jorb;
wire [1:0] exe_controlmem;
wire exe_controlwb;
wire [15:0] exe_WData;
wire [15:0] exe_ALURes;
wire [15:0] exe_NewPC;
wire [1:0] exe_ControlBTB;
wire [1:0] exe_forward;
wire [1:0] exe_forwardA;
wire [1:0] exe_forwardB;

// output and input of Mem
wire mem_write;
wire mem_read;
wire [15:0] mem_address;
wire [15:0] mem_wdata;
wire [15:0] mem_readdata;
wire mem_controlwb;
wire [3:0] mem_wreg;

// output and input of WB
wire wb_memtoreg;
wire [15:0] wb_memdata;
wire [15:0] wb_aludata;
wire [3:0] wb_wreg;
wire [15:0] wb_writeback;

wire pcKeep;
wire ifKeep;
wire ifClear;
wire idClear;
wire error;
wire [15:0] prePC;

BTB _BTB(
    .rst(rst),
    .clk(clk),
    .curPC(pc),
    .prePC(prePC),
    .ifJump_id(ifJump),
    .jFromPC(exe_pc),
    .jToPC(exe_NewPC),
    .ifJump(exe_ifjump),
    .error(error)
);

pll_controller _pll (
    .CLKIN_IN(clk), 
    .RST_IN(rst), 
    .CLKIN_IBUFG_OUT(CLKIN_IBUFG_OUT), 
    .CLK0_OUT(CLK0_OUT), 
    .CLK2X_OUT(clk2x), 
    .LOCKED_OUT(LOCKED_OUT)
    );

InstructMemory _im(
	 .clk(clk2x),
    .rst(rst),
	 .MemRead(mem_read),
	 .MemWrite(mem_write),
    .pc(pc),
	 .DM_Address(mem_address),
	 .Ram1Data(ram1_data), //Read from the main bus.
	 .Ram1Addr(ram1_addr),
	 .Instruct(instruction),
	 .MemConflict(mem_conflict),
    .Ram1OE(ram1_oe),
    .Ram1WE(ram1_we),
    .Ram1EN(ram1_en)
    );
	 
PC_reg _PC_reg(
    .PCKeep(pcKeep),
	 .clk (clk),
	 .rst (rst),
	 .ifJump(exe_ifjump),
    .newPC(exe_NewPC),
	 .pc(pc),
    .error(error),
    .prePC(prePC)
	// .AddedPC (addedPc)
);

if_id _if_id(
	.clk (clk),
    .ifkeep (ifKeep),
    .ifClear(ifClear),
    .pc_in (pc),
    .instr_in (instruction),
    .pc_out (idPC),
    .instr_out (idInstruction)
);

ID _ID(
	.ledA(ledA),
	.ledB(ledB),
    .clk(clk),
    .rst(rst),
  	.instr(idInstruction),
  	.writeBackReg(wb_wreg),
  	.writeBackData(wb_writeback),

    .ALUOp(ALUOp),
    .controlB(controlB),
    .controlMem(controlMem),
    .ifJump(ifJump),
    .immNum(immNum),
    .jorB(jorB),
    .memToReg(memToReg),
    .readReg1(readReg1),
    .writeReg(writeReg),
    .readReg2(readReg2),
    .readData1(readData1),
    .readData2(readData2)
);

id_exe _id_exe(
	.clk (clk),
    .idClear(idClear),
    .rdata1_in (readData1),
    .rdata2_in (readData2),
    .imme_in (immNum),
    .wreg_in (writeReg),
    .rreg1_in (readReg1),
    .rreg2_in (readReg2),
    .pc_in (idPC),
    .aluop_in (ALUOp),
    .controlb_in (controlB),
    .ifjump_in (ifJump),
    .jorb_in (jorB),
    .controlmem_in (controlMem),
    .controlwb_in (memToReg),
    .rdata1_out (exe_rdata1),
    .rdata2_out (exe_rdata2),
    .imme_out (exe_imme),
    .wreg_out (exe_wreg),
    .rreg1_out (exe_rreg1),
    .rreg2_out (exe_rreg2),
    .pc_out (exe_pc),
    .aluop_out (exe_aluop),
    .controlb_out (exe_controlb),
    .ifjump_out (exe_ifjump),
    .jorb_out (exe_jorb),
    .controlmem_out (exe_controlmem),
    .controlwb_out (exe_controlwb)
);

Exe _Exe(
	.clk (clk),
	.RData1 (exe_rdata1),
   .RData2 (exe_rdata2),
   .Imme (exe_imme),
   .WData (exe_WData),
   .PCSrc (exe_pc),
   .ALUOp (exe_aluop),
   .ControlB (exe_controlb),//00 01 10 11
   .ALURes (exe_ALURes),
   .NewPC (exe_NewPC),
   //.ControlBTB (),
	.JorB (exe_jorb),
	.ALUBack (mem_address),
	.WriteBackData (wb_writeback),
	.Forward (exe_forward),
	.ForwardingA (exe_forwardA),
	.ForwardingB (exe_forwardB)
);

Forwarding _forward(
    .rst (rst),
    .WRegFW1 (mem_wreg),
    .WRegFW2 (wb_wreg),
    .R1 (exe_rreg1),
    .R2 (exe_rreg2),
    .MemControl (exe_controlmem),
    .RData1 (exe_rdata1),
    .RData2 (exe_rdata2),
    .Forward (exe_forward),
    .ForwardingA (exe_forwardA),
    .ForwardingB (exe_forwardB)
);

hazard _hazard(
    // .ifJump(ifJump),
    .error(error),
    .readReg1(readReg1),
    .readReg2(readReg2),
    .writeReg(exe_wreg),
    .controlMem(exe_controlmem),
    .ifKeep(ifKeep),
    .ifClear(ifClear),
    .pcKeep(pcKeep),
    .idClear(idClear)
);

exe_mem _ex_m(
	.clk (clk),
	.controlmem_in (exe_controlmem),
	.controlwb_in (exe_controlwb),
	.alu_in (exe_ALURes),
	.wdata_in (exe_WData),
	.wreg_in (exe_wreg),
	.memwrite_out (mem_write),
	.memread_out (mem_read),
	.controlwb_out (mem_controlwb),
	.alu_out (mem_address),
	.wdata_out (mem_wdata),
	.wreg_out (mem_wreg)
);

DataMemory _dm(
	.Address(mem_address),
	.WriteData(mem_wdata),
	.MemRead(mem_read),
	.MemWrite(mem_write),
	.tbre(tbre),
	.tsre(tsre),
	.clk(clk2x),
	.data_ready(data_ready),
	.Ram1Data(ram1_data),
	.Ram2Data(ram2_data),
	.ReadData(mem_readdata),
	.Ram1Addr(ram1_addr),
	.Ram2Addr(ram2_addr),
	.Ram1OE(ram1_oe),
	.Ram1WE(ram1_we),
	.Ram1EN(ram1_en),
	.Ram2OE(ram2_oe),
	.Ram2WE(ram2_we),
	.Ram2EN(ram2_en),
	.rdn(rbn),
	.wrn(wrn)
);

mem_wb _mem_wb(
    .clk (clk),
    .controlwb_in (mem_controlwb),
    .memdata_in (mem_readdata),
    .alu_in (mem_address),
    .wreg_in (mem_wreg),
    .controlwb_out (wb_memtoreg),
    .memdata_out (wb_memdata),
    .alu_out (wb_aludata),
    .wreg_out (wb_wreg)
);

WriteBack _wb(
	.clk (clk),
	.WriteBackData (wb_writeback),
	.mem (wb_memdata),
	.alu (wb_aludata),
	.MemToReg (wb_memtoreg)
);

endmodule
