#include "basm/state.h"
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>

int
basm_state_init(struct basm_state *state, const char *in_path)
{
    int in_fd, error;

    if (state == NULL || in_path == NULL) {
        errno = -EINVAL;
        return -1;
    }

    if ((in_fd = open(in_path, O_RDONLY)) < 0) {
        return -1;
    }

    if (ptrbox_init(&state->ptrbox) < 0) {
        close(in_fd);
        return -1;
    }

    if ((error = basm_readbuf_init(in_fd, &state->readbuf)) < 0) {
        close(in_fd);
        ptrbox_destroy(&state->ptrbox);
        return -1;
    }

    return 0;
}

void
basm_state_destroy(struct basm_state *state)
{
    int in_fd;

    if (state == NULL) {
        return;
    }

    in_fd = readbuf_fd(&state->readbuf);
    close(in_fd);
    ptrbox_destroy(&state->ptrbox);
}
