#ifndef BASM_PARSER_H
#define BASM_PARSER_H 1

#include "basm/state.h"

/*
 * Begin parsing the input source file
 *
 * @state: Assembler state
 */
int parser_parse(struct basm_state *state);

#endif  /* !BASM_PARSER_H */
