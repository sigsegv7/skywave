#include "basm/lexer.h"
#include "basm/readbuf.h"
#include "basm/trace.h"
#include <errno.h>

/*
 * Returns true if the given character is a
 * whitespace character
 *
 * @c: Character to test
 */
static inline bool
lexer_is_ws(char c)
{
    switch (c) {
    case '\t':
    case '\f':
    case '\r':
    case ' ':
        return true;
    }

    return false;
}

/*
 * Nom a single byte from the input source file
 *
 * @state:   Assembler state
 * @skip_ws: If true, skipp whitespace
 */
static char
lexer_nom(struct basm_state *state, bool skip_ws)
{
    char c;

    if (state == NULL) {
        errno = -EINVAL;
        return '\0';
    }

    /*
     * Pull a token in from the read buffer until we have
     * something acceptable (i.e., not a whitespace when
     * we aren't skipping them)
     */
    for (;;) {
        c = basm_readbuf_pop(&state->readbuf);
        if (c == '\0') {
            break;
        }

        if (lexer_is_ws(c) && skip_ws) {
            continue;
        }

        break;
    }

    return c;
}

int
lexer_consume(struct basm_state *state, struct token *res)
{
    char c;

    if (state == NULL || res == NULL) {
        errno = -EINVAL;
        return -1;
    }

    if ((c = lexer_nom(state, true)) == '\0') {
        errno = -EAGAIN;
        return -1;
    }

    switch (c) {
    case '\n':
        res->type = TT_NEWLINE;
        res->c = c;
        return 0;
    case ',':
        res->type = TT_COMMA;
        res->c = c;
        return 0;
    default:
        trace_error(state, "unexpected token '%c'\n", c);
        break;
    }

    return -1;
}
