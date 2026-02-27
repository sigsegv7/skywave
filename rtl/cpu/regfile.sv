`include "regs.svh"

//
// On-core register file
//
// @clk_i:      Clock input
// @reset_i:    Reset input
// @write_en_i: If high, target register is written
// @reg_id_i:   ID of target register
// @value_i:    Write value input
// @value_o:    Read value output
//
module regfile #(
    parameter WORD_LEN = 64,
    parameter GP_RESET_VALUE = 64'hAAAAAAAAAAAAAAAA
) (
    input wire clk_i,
    input wire reset_i,
    input wire write_en_i,
    input reg_t reg_id_i,
    input [WORD_LEN-1:0] value_i,

    output [WORD_LEN-1:0] value_o
);
    logic [WORD_LEN-1:0] reg_pool [0:15];

    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            reg_pool[REG_G0] <= GP_RESET_VALUE;
            reg_pool[REG_G1] <= GP_RESET_VALUE;
            reg_pool[REG_G2] <= GP_RESET_VALUE;
            reg_pool[REG_G3] <= GP_RESET_VALUE;
            reg_pool[REG_G4] <= GP_RESET_VALUE;
            reg_pool[REG_G5] <= GP_RESET_VALUE;
            reg_pool[REG_G6] <= GP_RESET_VALUE;
            reg_pool[REG_G7] <= GP_RESET_VALUE;
            reg_pool[REG_A0] <= GP_RESET_VALUE;
            reg_pool[REG_A1] <= GP_RESET_VALUE;
            reg_pool[REG_A2] <= GP_RESET_VALUE;
            reg_pool[REG_A3] <= GP_RESET_VALUE;
            reg_pool[REG_A4] <= GP_RESET_VALUE;
            reg_pool[REG_A5] <= GP_RESET_VALUE;
            reg_pool[REG_A6] <= GP_RESET_VALUE;
            reg_pool[REG_A7] <= GP_RESET_VALUE;
        end else if (write_en_i) begin
            reg_pool[reg_id_i] <= value_i;
        end
    end

    always_comb begin
        value_o = reg_pool[reg_id_i];
    end
endmodule
