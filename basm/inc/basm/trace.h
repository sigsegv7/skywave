#ifndef BASM_TRACE_H
#define BASM_TRACE_H 1

#include <stdio.h>

#define trace_error(state, fmt, ...)            \
    printf("[error] " fmt, ##__VA_ARGS__);

#endif  /* !BASM_TRACE_H */
