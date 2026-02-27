`include "inst.svh"

//
// On-core control unit
//
// @clk_i:          Clock input
// @reset_i:        Reset input
//
module ctl (
    input wire clk_i,
    input wire reset_i
);
    /* verilator lint_off UNUSEDSIGNAL */
    logic pc_inhibit;
    logic [2:0] substage;
    logic inst_ready;

    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            pc_inhibit <= 0;
            substage <= 0;
            inst_ready <= 0;
        end
    end
endmodule
