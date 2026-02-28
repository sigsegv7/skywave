`ifndef INST_SVH
`define INST_SVH

typedef enum logic [7:0] {
    OPCODE_NOP  = 8'h00,
    OPCODE_HLT  = 8'h01,
    OPCODE_IMOV = 8'h02,
    OPCODE_IADD = 8'h04,
    OPCODE_ISUB = 8'h05,
    OPCODE_IAND = 8'h06,
    OPCODE_IOR  = 8'h07
} opcode_t;

`endif
