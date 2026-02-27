`include "regs.svh"

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
    parameter BUS_WIDTH = 32,
    parameter WORD_LEN = 64
) (
    input wire clk_i,
    input wire reset_i,
    input wire [BUS_WIDTH-1:0] bus_data_i,

    output logic [AD_LEN-1:0] bus_ad_o
);
    logic inst_valid_feed;
    logic [31:0] pc_feed;
    logic [31:0] inst_feed;
    logic [WORD_LEN-1:0] reg_value_feed;
    logic [WORD_LEN-1:0] reg_value_pool;
    logic reg_write_en_feed;
    reg_t reg_id_feed;

    ctl #(.WORD_LEN(WORD_LEN)) ctl_unit (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .inst_i(inst_feed),
        .inst_valid_i(inst_valid_feed),
        .reg_value_i(reg_value_pool),
        .pc_o(pc_feed),
        .reg_write_en_o(reg_write_en_feed),
        .reg_value_o(reg_value_feed),
        .reg_id_o(reg_id_feed)
    );

    fetch #(.AD_LEN(AD_LEN), .BUS_WIDTH(BUS_WIDTH)) fetch_unit (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .pc_i(pc_feed),
        .bus_data_i(bus_data_i),
        .bus_ad_o(bus_ad_o),
        .inst_valid_o(inst_valid_feed),
        .inst_o(inst_feed)
    );

    regfile #(.WORD_LEN(WORD_LEN)) reg_file (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .write_en_i(reg_write_en_feed),
        .reg_id_i(reg_id_feed),
        .value_i(reg_value_feed),
        .value_o(reg_value_pool)
    );
endmodule
