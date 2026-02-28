#include <stdio.h>
#include <unistd.h>
#include "basm/state.h"
#include "basm/parser.h"

/* BASM version */
#define BASM_VERSION "0.0.1"

static void
help(void)
{
    printf(
        "BASM assembler - skywave assembler\n"
        "----------------------------------\n"
        "[-h] Display help menu\n"
        "[-v] Display version\n"
    );
}

static void
version(void)
{
    printf(
        "BASM assembler - skywave assembler\n"
        "----------------------------------\n"
        "Copyright (c) 2026, Ian Moffett\n"
        "Version v%s\n",
        BASM_VERSION
    );
}

static int
assemble(const char *in_path)
{
    struct basm_state state;

    if (basm_state_init(&state, in_path) < 0) {
        printf("fatal: failed to initialize state\n");
        perror("basm_state_init");
        return -1;
    }

    if (parser_parse(&state) < 0) {
        return -1;
    }

    basm_state_destroy(&state);
    return 0;
}

int
main(int argc, char **argv)
{
    int opt;

    while ((opt = getopt(argc, argv, "hv")) != -1) {
        switch (opt) {
        case 'h':
            help();
            return -1;
        case 'v':
            version();
            return -1;
        }
    }

    while (optind < argc) {
        if (assemble(argv[optind++]) < 0) {
            return -1;
        }
    }

    return 0;
}
