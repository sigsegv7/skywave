`include "inst.svh"
`include "regs.svh"
`include "alu.svh"

//
// On-core control unit
//
// @clk_i:          Clock input
// @reset_i:        Reset input
// @inst_valid_i:   If high, a valid instruction is ready
// @inst_i:         Fetch unit instruction input
// @reg_value_i:    Input register value input
// @alu_op_res_i:   ALU operation result input
// @pc_o:           Program counter output to fetch unit
// @reg_write_en_o: If high, target register is written to
// @reg_value_o:    Value to write to register
// @reg_id_o:       Target register output
// @alu_op_a_o:     ALU operand A output
// @alu_op_b_o:     ALU operand B output
// @alu_opc_o:      ALU operation code output
// @reset_o:        RESET line output
//
module ctl #(
    parameter WORD_LEN = 64
) (
    input wire clk_i,
    input wire reset_i,
    input wire inst_valid_i,
    input wire [31:0] inst_i,
    input wire [WORD_LEN-1:0] reg_value_i,
    input wire [WORD_LEN-1:0] alu_op_res_i,

    output logic [31:0] pc_o,
    output logic reg_write_en_o,
    output logic [WORD_LEN-1:0] reg_value_o,
    output reg_t reg_id_o,

    output logic [WORD_LEN-1:0] alu_op_a_o,
    output logic [WORD_LEN-1:0] alu_op_b_o,
    output alu_op_t alu_opc_o,
    output logic reset_o
);
    /* verilator lint_off WIDTHEXPAND */
    logic [31:0] pc;
    logic [31:0] inst;
    logic need_decode;
    logic pc_inhibit;
    logic substage;

    assign pc_o = pc;

    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            pc <= 0;
            need_decode <= 0;
            pc_inhibit <= 0;
            reg_write_en_o <= 0;
            reg_value_o <= 0;
            reg_id_o <= reg_t'(0);
            substage <= 0;
            reset_o <= 0;
        end else if (inst_valid_i && !need_decode && !pc_inhibit) begin
            reg_write_en_o <= 0;
            need_decode <= 1;
            inst <= inst_i;
            pc <= pc + 4;
        end else if (need_decode) begin
            case (inst[7:0])
                OPCODE_NOP: ;
                OPCODE_HLT: begin
                    pc_inhibit <= 1;
                    need_decode <= 0;
                end
                OPCODE_IMOV: begin
                    reg_id_o <= reg_t'(inst[15:8]);
                    reg_value_o <= inst[31:16];
                    reg_write_en_o <= 1;
                    need_decode <= 0;
                end
                OPCODE_IADD: begin
                    reg_id_o <= reg_t'(inst[15:8]);
                    alu_opc_o <= ALU_OP_ADD;

                    if (!substage) begin
                        substage <= ~substage;
                        alu_op_a_o <= reg_value_i;
                        alu_op_b_o <= inst[31:16];
                    end else begin
                        substage <= ~substage;
                        reg_value_o <= alu_op_res_i;
                        reg_write_en_o <= 1;
                        need_decode <= 0;
                    end
                end
                default: reset_o <= 1;
            endcase
        end
    end
endmodule
