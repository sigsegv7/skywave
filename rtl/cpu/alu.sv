`include "alu.svh"

//
// On-core arithmatic logic unit
//
// @op_a_i:   Operand A input
// @op_b_i:   Operand B input
// @opc_i:    ALU operation to perform,
// @op_res_o: Opeation result output
//
module alu #(
    parameter WORD_LEN = 64
) (
    input wire [WORD_LEN-1:0] op_a_i,
    input wire [WORD_LEN-1:0] op_b_i,
    input alu_op_t opc_i,

    output wire [WORD_LEN-1:0] op_res_o
);
    always_comb begin
        case (opc_i)
            ALU_OP_ADD: op_res_o = (op_a_i + op_b_i);
            ALU_OP_SUB: op_res_o = (op_a_i - op_b_i);
            default:    op_res_o = 0;
        endcase
    end
endmodule
