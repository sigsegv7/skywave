//
// Skywave-A System-on-Chip (SoC) package
//
// @clk_i:      Clock input
// @reset_i:    RESET# input
//
module skywave #(
    parameter AD_LEN = 32,
    parameter BUS_WIDTH = 32
) (
    input wire clk_i,
    input wire reset_i
);
    logic reset;
    logic clk;
    logic [AD_LEN-1:0] bus_ad_feed;
    logic [BUS_WIDTH-1:0] bus_data_pool;

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
    always_ff @(posedge clk) begin
        reset <= ~reset_i | ~pll_locked;
    end
`else
    assign clk = clk_i;
    always_ff @(posedge clk) begin
        reset <= ~reset_i;
    end
`endif  /* !SKYWAVE_SIM */

    // Main bus fabric
    busctl #(.AD_LEN(AD_LEN), .BUS_WIDTH(BUS_WIDTH)) mainbus (
        .clk_i(clk),
        .reset_i(reset),
        .ad_i(bus_ad_feed),
        .data_o(bus_data_pool)
    );

    // Processor core 0
    pe #(.AD_LEN(AD_LEN), .BUS_WIDTH(BUS_WIDTH)) core0 (
        .clk_i(clk),
        .reset_i(reset),
        .bus_data_i(bus_data_pool),
        .bus_ad_o(bus_ad_feed)
    );
endmodule
