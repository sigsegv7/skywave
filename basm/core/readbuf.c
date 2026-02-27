#include "basm/readbuf.h"
#include <string.h>
#include <unistd.h>
#include <errno.h>

int
basm_readbuf_init(int fd, struct basm_readbuf *res)
{
    if (fd < 0 || res == NULL) {
        errno = -EINVAL;
        return -1;
    }

    memset(res, 0, sizeof(*res));
    res->fd = fd;
    res->chunk_cap = 0;
    res->chunk_ind = 0;
    return 0;
}

char
basm_readbuf_pop(struct basm_readbuf *rb)
{
    ssize_t count;

    if (rb == NULL) {
        return '\0';
    }

    /*
     * If there is no data to obtain from the read buffer or we have
     * exceeded the chunk size, pull in more data.
     */
    if (rb->chunk_cap == 0 || rb->chunk_ind >= rb->chunk_cap) {
        if ((count = read(rb->fd, rb->chunk, READBUF_CHUNK_SZ)) <= 0)
            return '\0';

        rb->chunk_cap = count;
        rb->chunk_ind = 0;
    }

    return rb->chunk[rb->chunk_ind++];
}
