NEW_C_SRCS  := src/testsrc/xtctest.c
NEW_DEPS    := $(NEW_C_SRCS:.c=.d)

C_SRCS      := $(C_SRCS) $(NEW_C_SRCS)
OBJS        := $(OBJS) $(NEW_C_SRCS:.c=.o)
DEPS        := $(DEPS) $(NEW_DEPS)
BINARIES    := $(BINARIES) src/testsrc/xtctest

-include $(NEW_DEPS)

src/testsrc/%.o: src/testsrc/%.c
	$(CC) -I$(LIB_INTERFACE) $(CFLAGS) -c $< -o $@

src/testsrc/xtctest: src/testsrc/xtctest.o src/libsrc/src/libxtc.so
	$(LD) $(LDFLAGS) $^ -o $@
