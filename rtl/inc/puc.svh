`ifndef PUC_SVH
`define PUC_SVH

//
// Valid power-up contracts
//
// @PUC_EOH: Exception overflow halt enable
// @PUC_ITAP: Indicator tap enable
//
typedef enum {
    PUC_EOH,
    PUC_ITAP
} puc_t;

`endif  /* !PUC_SVH */
