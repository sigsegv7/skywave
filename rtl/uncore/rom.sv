//
// Uncore ROM
//
// @clk_i:   Clock input
// @reset_i: Reset input
// @ad_i:    Address input
// @data_o:  Data output
//
module rom #(
    parameter AD_LEN = 32,
    parameter BUS_WIDTH = 32,
    parameter ROM_MAX_ADDR = 14'h2000
) (
    input wire clk_i,
    input wire reset_i,
    input wire [AD_LEN-1:0] ad_i,

    output logic [BUS_WIDTH-1:0] data_o
);
    //
    // 8 KiB uncore ROM, this is to contain stage 1 platform
    // firmware which performs highly platform specific initialization
    // before handing off control to stage 2 firmware.
    //
    logic [BUS_WIDTH-1:0] rom [0:2048];

    // Handle preload, reset and read
    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            $readmemh("stage1.mem", rom);
        end else if (ad_i < ROM_MAX_ADDR) begin
            data_o <= rom[ad_i>>2];
        end
    end
endmodule
