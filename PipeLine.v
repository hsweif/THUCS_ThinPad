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
	input clk_orig, // TODO: need to be checked
	input rst,
//input clk,
	output [7:0] ledA,
	output [7:0] ledB,
	output ram1_oe,
	output ram1_en,
	output ram1_we,
	output ram2_oe,
	output ram2_en,
	output ram2_we,
	inout [15:0] ram1_data,
	inout [15:0] ram2_data,
	output [17:0] ram1_addr,
	output [17:0] ram2_addr,
	output reg [1:0] debug,
	input data_ready,
	input tbre,
	input tsre,
	output rdn,
	output wrn,
	output [2:0] R,
   output [2:0] G,
   output [2:0] B,
   output Hs,
   output Vs
    );

// output and input for PLL
wire clk2x;
//wire clk;
//wire clk_o;
// output and input of IF
wire [15:0] pc;
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
wire [1:0] exe_forward;
wire [1:0] exe_forwardA;
wire [1:0] exe_forwardB;

// output and input of Mem
wire mem_write;
wire mem_read;
wire no_stop;
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
wire idKeep;
wire exeKeep;
wire ifKeep;
wire ifClear;
wire idClear;
wire error;
wire [15:0] prePC;
wire clk;
wire clk_out;

wire [15:0] R0;
wire [15:0] R1;
wire [15:0] R2;
wire [15:0] R3;
wire [15:0] R4;
wire [15:0] R5;
wire [15:0] R6;
wire [15:0] R7;
wire [15:0] R8;
wire [15:0] R9;
wire [15:0] R10;

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
wire clk2x_o;
pll_controller _pll (
    .CLKIN_IN(clk_orig), 
	 .CLKDV_OUT(clk)
    );
	 
dcm_pll _dcm1 (
    .CLKIN_IN(clk),  
    .CLK2X_OUT(clk2x)
    );
	 
/*fenpin _fenpin1(
	.clk (clk_out),
	.clk_out (clk_o)
);

fenpin _fenpin2(
	.clk (clk2x_o),
	.clk_out (clk2x)
);*/


/*dcm2 _dcm2 (
    .CLKIN_IN(clk), 
    .CLK2X_OUT(clk2x)
    );
	*/ 
/* FIXME
always @(*)
begin
    clk <= clk_o & no_stop;
end
*/
wire color;
wire [10:0] row;
wire [10:0] col;
vga _vga(
	.clk(clk),
   .rst(rst),
	 .R0(R0),
	 .R1(R1),
	 .R2(R2),
	 .R3(R3),
	 .R4(R4),
	 .R5(R5),
	 .R6(R6),
	 .R7(R7),
	 .R8(R8),
	 .R9(R9),
	 .R10(R10),
   .R(R),
   .G(G),
   .B(B),
   .Hs(Hs),
   .Vs(Vs)
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
);

/*InstructionMemory _IM(
	
	//.ledB(ledB),
    .memConflict(mem_conflict),
	.clk(clk),
	.rst (rst),
   .pc (pc),
   .Instruction (instruction)
);*/

MemoryModule _mem(
	.clk_main(clk),
	.clk(clk2x),
    .rst(rst),
    .pc(pc),
    .MemConflict(mem_conflict),
	.Address(mem_address),
	.WriteData(mem_wdata),
	.MemRead(mem_read),
	.MemWrite(mem_write),
	.ReadData(mem_readdata),
   .Instruct(instruction), // FIXME: is here right?
	.Ram1Data(ram1_data),
	.Ram1Addr(ram1_addr),
	.Ram1OE(ram1_oe),
	.Ram1WE(ram1_we),
	.Ram1EN(ram1_en),
	.Ram2Data(ram2_data),
	.Ram2Addr(ram2_addr),
	.Ram2OE(ram2_oe),
	.Ram2WE(ram2_we),
	.Ram2EN(ram2_en),
    .noStop(no_stop),
	.data_ready(data_ready),
	.tbre(tbre),
	.tsre(tsre),
	.rdn(rdn),
	.wrn(wrn)
);

// Use for testing uart.
always @(*)
begin
	debug[0] <= data_ready;
	debug[1] <= no_stop;
	//clk <= clk_o & no_stop;
end

if_id _if_id(
	.rst(rst),
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
	 .R0(R0),
	 .R1(R1),
	 .R2(R2),
	 .R3(R3),
	 .R4(R4),
	 .R5(R5),
	 .R6(R6),
	 .R7(R7),
	 .R8(R8),
	 .R9(R9),
	 .R10(R10),
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
.rst(rst),
	.clk (clk),
    .idKeep(idKeep),
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
    .Forward (exe_forward),
    .ForwardingA (exe_forwardA),
    .ForwardingB (exe_forwardB)
);

hazard _hazard(
    // .ifJump(ifJump),
    .error(error),
    .uartConflict(no_stop),
    .readReg1(readReg1),
    .readReg2(readReg2),
    .writeReg(exe_wreg),
    .memConflict(mem_conflict),
    .controlMem(exe_controlmem),
    .ifKeep(ifKeep),
    .idKeep(idKeep),
    .exeKeep(exeKeep),
    .ifClear(ifClear),
    .pcKeep(pcKeep),
    .idClear(idClear)
);

exe_mem _ex_m(
.rst(rst),
	.clk (clk),
    .exeKeep(exeKeep),
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



mem_wb _mem_wb(
.rst(rst),
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
