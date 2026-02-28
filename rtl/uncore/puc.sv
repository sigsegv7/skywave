//
// Uncore power-up contract unit (PUC)
//
// @clk_i:          Clock input
// @reset_i:        Reset input
// @puc_cap<n>_i:   Capability pins
// @puc_o:          Power-up contract output
//
module puc #(
    parameter N_PUC = 2
) (
    input wire clk_i,
    input wire reset_i,

    input wire puc_cap0_i,
    input wire puc_cap1_i,

    output logic [N_PUC-1:0] puc_o
);
    logic [N_PUC-1:0] puc_latch;

    assign puc_o = puc_latch;

    //
    // Upon reset, the cap pins are to be latched in their
    // normalized form (i.e., active-high internally).
    //
    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            puc_latch[0] <= ~puc_cap0_i;
            puc_latch[1] <= ~puc_cap1_i;
        end
    end
endmodule
