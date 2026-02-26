`ifndef INST_SVH
`define INST_SVH

typedef enum logic [7:0] {
    OPCODE_NOP = 8'h00,
    OPCODE_HLT = 8'h01
} opcode_t;

`endif
