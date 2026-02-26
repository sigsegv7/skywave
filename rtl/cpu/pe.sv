//
// Processing element
//
// @clk_i:      Clock input
// @reset_i:    Reset input
// @bus_data_i: Bus data input
// @bus_ad_o:   Bus address output
//
module pe #(
    parameter AD_LEN = 32,
    parameter BUS_WIDTH = 32
) (
    input wire clk_i,
    input wire reset_i,
    input wire [BUS_WIDTH-1:0] bus_data_i,

    output logic [AD_LEN-1:0] bus_ad_o
);
    /* verilator lint_off UNUSEDSIGNAL */
    logic [31:0] inst_feed;
    logic inst_ready_feed;
    logic inst_consume_feed;

    fetch #(.BUS_WIDTH(BUS_WIDTH), .AD_LEN(AD_LEN)) fetch_unit (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .bus_data_i(bus_data_i),
        .inst_consume_i(inst_consume_feed),
        .bus_ad_o(bus_ad_o),
        .inst_o(inst_feed),
        .inst_ready_o(inst_ready_feed)
    );

    ctl ctl_unit (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .inst_i(inst_feed),
        .inst_ready_i(inst_ready_feed),
        .inst_consume_o(inst_consume_feed)
    );
endmodule
