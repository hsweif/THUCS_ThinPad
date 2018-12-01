`define RAM1_UPPER 16'b0111111111111111 //0x7FFF
`define COM1_DATA 16'b1011111100000000 //0xBF00
`define COM1_COMMAND 16'b1011111100000001 //0xBF01
`define COM2_DATA 16'b1011111100000010 //0xBF02
`define COM2_COMMAND 16'b1011111100000011 //0xBF03
`define NOP_INSTRUCT 16'b0000100000000000 // NOP
`define FLASH_ERASE_OP 16'h0020
`define FLASH_ERASE 16'h00D0
`define FLASH_READ_OP 16'h00FF
`define FLASH_WRITE_OP 16'h0040
`define ZERO 16'b0000000000000000
// Should I predefined preserverd ports, such as 0xBF0f?