#ifndef BASM_LEXER_H
#define BASM_LEXER_H 1

#include "basm/state.h"
#include "basm/lexer.h"
#include "basm/token.h"

/*
 * Consume a single token from the input source
 *
 * @state: Assembler state
 * @res:   Resulting token is written here
 *
 * Returns zero on success
 */
int lexer_consume(struct basm_state *state, struct token *res);

#endif  /* !BASM_LEXER_H */
