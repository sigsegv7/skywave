/*
 * On-core fetch unit
 *
 * @clk_i:       Input clock
 * @reset_i:     Reset input
 * @pc_i:        Program counter input
 * @bus_data_i:  Bus data input
 * @bus_ad_o'    Bus address output
 * @inst_valid_o: Bus valid signal output
 * @inst_o:      Intruction result output
 */
module fetch #(
    parameter AD_LEN = 32,
    parameter BUS_WIDTH = 32,

    parameter STAGE_MEM_REQ = 0,
    parameter STAGE_MEM_WAIT = 1,
    parameter STAGE_PC_LATCH = 2,
    parameter STAGE_WAIT = 3
) (
    input wire clk_i,
    input wire reset_i,
    input wire [31:0] pc_i,
    input wire [BUS_WIDTH-1:0] bus_data_i,

    output logic [AD_LEN-1:0] bus_ad_o,
    output logic inst_valid_o,
    output logic [31:0] inst_o
);
    logic [2:0] stage;

    always @(posedge clk_i) begin
        if (reset_i) begin
            stage <= 0;
        end else begin
            case (stage)
                STAGE_MEM_REQ: begin
                    bus_ad_o <= pc_i;
                    inst_valid_o <= 0;
                    stage <= STAGE_MEM_WAIT;
                end
                STAGE_MEM_WAIT: begin
                    stage <= STAGE_PC_LATCH;
                end
                STAGE_PC_LATCH: begin
                    stage <= STAGE_WAIT;
                    inst_valid_o <= 1;
                    inst_o <= bus_data_i;
                end
                STAGE_WAIT: begin
                    stage <= STAGE_MEM_REQ;
                end
            endcase
        end
    end
endmodule
