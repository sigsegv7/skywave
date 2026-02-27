`include "inst.svh"
`include "regs.svh"

//
// On-core control unit
//
// @clk_i:          Clock input
// @reset_i:        Reset input
//
module ctl #(
    parameter WORD_LEN = 64
) (
    input wire clk_i,
    input wire reset_i,
    input wire inst_valid_i,
    input wire [31:0] inst_i,

    /* verilator lint_off UNUSEDSIGNAL */
    input wire [WORD_LEN-1:0] reg_value_i,

    output logic [31:0] pc_o,
    output logic reg_write_en_o,
    output logic [WORD_LEN-1:0] reg_value_o,
    output reg_t reg_id_o
);
    /* verilator lint_off WIDTHEXPAND */
    logic [31:0] pc;
    logic [31:0] inst;
    logic need_decode;
    logic pc_inhibit;

    assign pc_o = pc;

    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            pc <= 0;
            need_decode <= 0;
            pc_inhibit <= 0;
            reg_write_en_o <= 0;
            reg_value_o <= 0;
            reg_id_o <= reg_t'(0);
        end else if (inst_valid_i && !need_decode && !pc_inhibit) begin
            reg_write_en_o <= 0;
            need_decode <= 1;
            inst <= inst_i;
            pc <= pc + 4;
        end else if (need_decode) begin
            need_decode <= 0;
            case (inst[7:0])
                OPCODE_NOP: ;
                OPCODE_HLT: pc_inhibit <= 1;
                OPCODE_IMOV: begin
                    reg_id_o <= reg_t'(inst[15:8]);
                    reg_value_o <= inst[31:16];
                    reg_write_en_o <= 1;
                end
                default: ;
            endcase
        end
    end
endmodule
