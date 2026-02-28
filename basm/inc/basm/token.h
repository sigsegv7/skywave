#ifndef BASM_TOKEN_H
#define BASM_TOKEN_H 1

/*
 * Represents valid token types
 */
typedef enum {
    TT_NONE,       /* <none> */
    TT_NEWLINE,    /* <newline> */
    TT_COMMA       /* ',' */
} tt_t;

/*
 * Token descriptor
 *
 * @type: Token type
 */
struct token {
    tt_t type;
    union {
        char c;
    };
};

#endif  /* !BASM_TOKEN_H */
