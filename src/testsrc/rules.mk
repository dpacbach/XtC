NEW_C_SRCS := src/testsrc/xtctest.c

C_SRCS      := $(C_SRCS) $(NEW_C_SRCS)
OBJS        := $(OBJS) $(NEW_C_SRCS:.c=.o)
BINARIES    := $(BINARIES) src/testsrc/xtctest

src/testsrc/%.o: src/testsrc/%.c
	$(CC) -I$(LIB_INTERFACE) $(CFLAGS) -c $< -o $@

src/testsrc/xtctest: src/testsrc/xtctest.o src/libsrc/src/libxtc.so
	$(LD) $(LDFLAGS) $^ -o $@
