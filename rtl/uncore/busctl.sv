//
// Uncore bus control unit
//
// @clk_i:   Clock input
// @reset_i: Reset input
// @ad_i:    Address input
// @data_o:  Data output
//
module busctl #(
    parameter AD_LEN = 32,
    parameter BUS_WIDTH = 32
) (
    input wire clk_i,
    input wire reset_i,
    input wire [AD_LEN-1:0] ad_i,

    output logic [BUS_WIDTH-1:0] data_o
);
    // Platform firmware ROM
    rom #(.BUS_WIDTH(BUS_WIDTH), .AD_LEN(AD_LEN)) pfw_rom (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .ad_i(ad_i),
        .data_o(data_o)
    );
endmodule
