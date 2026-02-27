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
    ctl ctl_unit (
        .clk_i(clk_i),
        .reset_i(reset_i)
    );

    always_ff @(posedge clk_i) begin
        bus_ad_o <= 0;
    end
endmodule
