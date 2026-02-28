`ifndef ALU_SVH
`define ALU_SVH

typedef enum logic [3:0] {
    ALU_OP_ADD = 4'h00,
    ALU_OP_SUB = 4'h01,
    ALU_OP_AND = 4'h02,
    ALU_OP_OR  = 4'h03
} alu_op_t;

`endif  /* !ALU_SVH */
