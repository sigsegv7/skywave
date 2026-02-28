include mk/default.mk

CFILES = $(shell find . -name "*.c")
DFILES = $(CFILES:.c=.d)
OFILES = $(CFILES:.c=.o)

.PHONY: all
all: $(OFILES)
	$(CC) $^ -o basm

-include $(DFILES)
%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@
