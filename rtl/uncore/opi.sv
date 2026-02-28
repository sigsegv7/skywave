//
// Uncore operator panel interface (OPI)
//
// @clk_i:          Clock input
// @reset_i:        Reset input
// @puc_cap<n>_i:   Capability pins
// @puc_o:          Power-up contract output
//
module opi #(
    parameter N_PUC = 2
) (
    input wire clk_i,
    input wire reset_i,
    input wire puc_cap0_i,
    input wire puc_cap1_i,

    output logic [N_PUC-1:0] puc_o
);
    logic [N_PUC-1:0] puc;

    // XXX: Assumes immutable
    assign puc_o = puc;

    puc #(.N_PUC(N_PUC)) puc_unit (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .puc_cap0_i(puc_cap0_i),
        .puc_cap1_i(puc_cap1_i),
        .puc_o(puc)
    );
endmodule
