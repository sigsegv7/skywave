#include "basm/parser.h"
#include "basm/token.h"
#include "basm/lexer.h"
#include <errno.h>
#include <stdio.h>

/* Convert token to string */
#define tokstr1(tt) \
    toktab[(tt)]

/* Convert token to string */
#define tokstr(tok) \
    tokstr1((tok)->type)

/* Symbolic token */
#define symtok(tok) \
    "[" tok "]"

/* Quoted token */
#define qtok(tok) \
    "'" tok "'"

/*
 * Table used to convert token type constants into
 * human readable strings.
 */
static const char *toktab[] = {
    [TT_NONE]       = symtok("none"),
    [TT_NEWLINE]    = symtok("newline"),
    [TT_COMMA]      = qtok(",")
};

int
parser_parse(struct basm_state *state)
{
    struct token tok;

    if (state == NULL) {
        errno = -EINVAL;
        return -1;
    }

    while (lexer_consume(state, &tok) == 0) {
        printf("got token %s\n", tokstr(&tok));
    }

    return 0;
}
