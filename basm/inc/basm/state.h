#ifndef BASM_STATE_H
#define BASM_STATE_H 1

#include <stdint.h>
#include <stddef.h>
#include "basm/readbuf.h"

/*
 * Assembler state machine
 *
 * @readbuf: Lexer read buffer
 */
struct basm_state {
    struct basm_readbuf readbuf;
};

/*
 * Initialize the assembler state machine
 *
 * @state:      Assembler state machine
 * @in_path:    Input path
 *
 * Returns zero on success
 */
int basm_state_init(struct basm_state *state, const char *in_path);

/*
 * Destroy the assembler state machine
 *
 * @state: State machine to destroy
 */
void basm_state_destroy(struct basm_state *state);

#endif  /* !BASM_STATE_H */
