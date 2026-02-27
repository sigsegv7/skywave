//
// On-core fetch unit
//
// @clk_i:          Clock input
// @reset_i:        Reset input
// @bus_data_i:     Bus data input
// @inst_consume_i: If high, next instruction is to be consumed
// @bus_ad_o:       Bus address output
// @inst_o:         Instruction output
// @inst_ready_o:   If high, instruction is ready
//
module fetch #(
    parameter BUS_WIDTH = 32,
    parameter AD_LEN = 32,
    parameter STAGE_REQ = 0,
    parameter STAGE_WAIT = 1,
    parameter STAGE_FETCH = 2,
    parameter STAGE_OUTPUT = 3
) (
    input wire clk_i,
    input wire reset_i,
    input wire [BUS_WIDTH-1:0] bus_data_i,
    input wire inst_consume_i,

    output logic [AD_LEN-1:0] bus_ad_o,
    output logic [31:0] inst_o,
    output logic inst_ready_o
);
    logic [31:0] pc;
    logic [31:0] inst;
    logic [2:0] stage;

    always @(posedge clk_i) begin
        if (reset_i) begin
            pc <= 0;
            inst <= 0;
            stage <= 0;
            inst_ready_o <= 0;
            inst_o <= 0;
            bus_ad_o <= 0;
        end else begin
            case (stage)
            STAGE_REQ: begin
                inst_ready_o <= 0;
                if (inst_consume_i) begin
                    bus_ad_o <= pc;
                    stage <= stage + 1;
                end
            end
            STAGE_WAIT: begin
                stage <= stage + 1;
            end
            STAGE_FETCH: begin
                inst <= bus_data_i;
                stage <= stage + 1;
            end
            STAGE_OUTPUT: begin
                inst_ready_o <= 1;
                if (!inst_consume_i) begin
                    inst_o <= inst;
                    stage <= 0;
                    pc <= pc + 4;
                end
            end
            endcase
        end
    end
endmodule
