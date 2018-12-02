`define RAM1_UPPER 16'b0111111111111111 //0x7FFF
`define COM1_DATA 16'hBF00
`define COM1_COMMAND 16'hBF01 //0xBF01
`define COM2_DATA 16'hBF02 //0xBF02
`define COM2_COMMAND 16'hBF03 //0xBF03
`define NOP_INSTRUCT 16'b0000100000000000 // NOP

// Should I predefined preserverd ports, such as 0xBF0f?