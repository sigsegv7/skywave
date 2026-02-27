`include "inst.svh"

//
// On-core control unit
//
// @clk_i:          Clock input
// @reset_i:        Reset input
// @inst_i:         Instruction input
// @inst_ready_i:   Instruction ready input
// @inst_consume_o: Instruction consume output
//
module ctl (
    input wire clk_i,
    input wire reset_i,
    input wire [31:0] inst_i,
    input wire inst_ready_i,

    output logic inst_consume_o
);
    logic pc_inhibit;
    logic substage;
    /* verilator lint_off UNUSEDSIGNAL */
    logic [31:0] inst;

    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            pc_inhibit <= 0;
            inst_consume_o <= 0;
            substage <= 0;
        end else if (!pc_inhibit && !inst_ready_i) begin
            inst_consume_o <= 1;
        end else if (!pc_inhibit && inst_ready_i && !substage) begin
            substage <= ~substage;
            inst <= inst_i;
        end else if (!pc_inhibit && inst_ready_i && substage) begin
            inst_consume_o <= 0;
            substage <= 0;
            case (inst[7:0])
                OPCODE_NOP:  ;
                OPCODE_HLT: pc_inhibit <= 1;
                default: ;
            endcase
        end else if (pc_inhibit) begin
            inst_consume_o <= 0;
        end
    end
endmodule
