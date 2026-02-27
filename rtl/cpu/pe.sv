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

    /* verilator lint_off UNUSEDSIGNAL */
    input wire [BUS_WIDTH-1:0] bus_data_i,

    output logic [AD_LEN-1:0] bus_ad_o
);
    logic inst_valid_feed;
    logic [31:0] pc_feed;
    logic [31:0] inst_feed;

    ctl ctl_unit (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .inst_i(inst_feed),
        .inst_valid_i(inst_valid_feed),
        .pc_o(pc_feed)
    );

    fetch fetch_unit (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .pc_i(pc_feed),
        .bus_data_i(bus_data_i),
        .bus_ad_o(bus_ad_o),
        .inst_valid_o(inst_valid_feed),
        .inst_o(inst_feed)
    );
endmodule
