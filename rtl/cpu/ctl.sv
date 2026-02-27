`include "inst.svh"

//
// On-core control unit
//
// @clk_i:          Clock input
// @reset_i:        Reset input
//
module ctl (
    input wire clk_i,
    input wire reset_i,
    input wire inst_valid_i,
    input wire [31:0] inst_i,

    output logic [31:0] pc_o
);
    /* verilator lint_off UNUSEDSIGNAL */
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
        end else if (inst_valid_i && !need_decode && !pc_inhibit) begin
            need_decode <= 1;
            inst <= inst_i;
            pc <= pc + 4;
        end else if (need_decode) begin
            need_decode <= 0;
            case (inst[7:0])
                OPCODE_NOP: ;
                OPCODE_HLT: pc_inhibit <= 1;
                default: ;
            endcase
        end
    end
endmodule
