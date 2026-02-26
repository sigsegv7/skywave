//
// Skywave-A System-on-Chip (SoC) package
//
// @clk_i:      Clock input
// @reset_i:    RESET# input
//
module skywave (
    input wire clk_i,
    input wire reset_i
);
    /* verilator lint_off UNUSEDSIGNAL */
    logic reset;
    logic clk;

    //
    // Reset bridge - not required with simulations
    //
`ifndef SKYWAVE_SIM
    logic pll_locked;

    pll soc_pll (
        .refclk(clk_i),
        .rst(reset_i),
        .outclk_0(clk),
        .locked(pll_locked)
    );

    //
    // For as long as RESET# is pulled low or the phased locked
    // loop is unlocked, drive 'reset' high.
    //
    always @(posedge clk) begin
        reset <= ~reset_i | ~pll_locked;
    end
`else
    assign clk = clk_i;
    always @(posedge clk) begin
        reset <= ~reset_i;
    end
`endif  /* !SKYWAVE_SIM */
endmodule
