#ifndef BASM_READBUF_H
#define BASM_READBUF_H 1

#include <stdint.h>
#include <stddef.h>

/* Maximum size of a readbuf chunk */
#define READBUF_CHUNK_SZ 64

/*
 * Read buffer descriptor
 *
 * @chunk: Chunk FIFO
 * @chunk_cap: Total length of chunk FIFO
 * @chunk_ind: Current index in chunk FIFO
 * @fd: Target file descriptor
 */
struct basm_readbuf {
    char chunk[READBUF_CHUNK_SZ];
    size_t chunk_cap;
    size_t chunk_ind;
    int fd;
};

/* Reference file descriptor from readbuf */
#define readbuf_fd(rb) \
    ((rb)->fd)

/*
 * Initialize a read buffer using a file descriptor
 *
 * @fd: File descriptor to initialize read buffer with
 * @res: Result is written here
 *
 * Returns zero on success
 */
int basm_readbuf_init(int fd, struct basm_readbuf *res);

/*
 * Pop a byte from a read buffer
 *
 * @rb: Read buffer to pop from
 *
 * Returns the byte on success, otherwise '\0' on
 * failure.
 */
char basm_readbuf_pop(struct basm_readbuf *rb);

#endif  /* !BASM_READBUF_H */
