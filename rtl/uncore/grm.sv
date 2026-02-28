//
// Global reset multiplexer
//
// @opi_reset_i:    OPI reset line             [ACTIVE-LOW]
// @pe0_reset_i:    Core 0 reset line
// @reset_o:        Resulting reset signal
//
module grm (
    input wire opi_reset_i,
    input wire pe0_reset_i,

    output logic reset_o
);
    always_comb begin
        reset_o = ~opi_reset_i | pe0_reset_i;
    end
endmodule
