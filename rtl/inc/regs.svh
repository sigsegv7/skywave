`ifndef REGS_SVH
`define REGS_SVH

typedef enum logic [3:0] {
    REG_G0 = 4'h00,
    REG_G1 = 4'h01,
    REG_G2 = 4'h02,
    REG_G3 = 4'h03,
    REG_G4 = 4'h04,
    REG_G5 = 4'h05,
    REG_G6 = 4'h06,
    REG_G7 = 4'h07,
    REG_A0 = 4'h08,
    REG_A1 = 4'h09,
    REG_A2 = 4'h0A,
    REG_A3 = 4'h0B,
    REG_A4 = 4'h0C,
    REG_A5 = 4'h0D,
    REG_A6 = 4'h0E,
    REG_A7 = 4'h0F
} reg_t;

`endif
