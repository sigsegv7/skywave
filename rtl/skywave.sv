//
// Skywave-A System-on-Chip (SoC) package
//
// @clk_i:          Clock input
// @reset_i:        RESET# input
// @puc_cap<n>_i:   Capability pins
//
module skywave #(
    parameter AD_LEN = 32,
    parameter BUS_WIDTH = 32,
    parameter N_PUC = 2
) (
    input wire clk_i,
    input wire reset_i,

    // Capability pins
    input wire puc_cap0_i,
    input wire puc_cap1_i
);
    logic reset;
    logic clk;
    logic [AD_LEN-1:0] bus_ad_feed;
    logic [BUS_WIDTH-1:0] bus_data_pool;
    logic g_reset;
    logic pe0_reset;
    logic [N_PUC-1:0] puc;

    // Global reset mux
    grm reset_mux (
        .opi_reset_i(reset_i),
        .pe0_reset_i(pe0_reset),
        .reset_o(g_reset)
    );

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
    // For as long as the global reset mux output is high or the
    // phased locked, loop is unlocked, drive 'reset' high.
    //
    always_ff @(posedge clk) begin
        reset <= g_reset | ~pll_locked;
    end
`else
    assign clk = clk_i;
    always_ff @(posedge clk) begin
        reset <= g_reset;
    end
`endif  /* !SKYWAVE_SIM */

    // Operator panel interface
    opi #(.N_PUC(N_PUC)) opi_unit (
        .clk_i(clk),
        .reset_i(reset),
        .puc_cap0_i(puc_cap0_i),
        .puc_cap1_i(puc_cap1_i),
        .puc_o(puc)
    );

    // Main bus fabric
    busctl #(.AD_LEN(AD_LEN), .BUS_WIDTH(BUS_WIDTH)) mainbus (
        .clk_i(clk),
        .reset_i(reset),
        .ad_i(bus_ad_feed),
        .data_o(bus_data_pool)
    );

    // Processor core 0
    pe #(.AD_LEN(AD_LEN), .BUS_WIDTH(BUS_WIDTH), .N_PUC(N_PUC))
    core0 (
        .clk_i(clk),
        .reset_i(reset),
        .bus_data_i(bus_data_pool),
        .puc_i(puc),
        .bus_ad_o(bus_ad_feed),
        .reset_o(pe0_reset)
    );
endmodule
