#include <stdio.h>
#include <unistd.h>

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

    return 0;
}
