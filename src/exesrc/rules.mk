NEW_C_SRCS  := src/exesrc/xtc_cmd.c
NEW_DEPS    := $(NEW_C_SRCS:.c=.d)

C_SRCS      := $(C_SRCS) $(NEW_C_SRCS)
OBJS        := $(OBJS) $(NEW_C_SRCS:.c=.o)
DEPS        := $(DEPS) $(NEW_DEPS)
BINARIES    := $(BINARIES) src/exesrc/xtc
EXECUTABLES := $(EXECUTABLES) src/exesrc/xtc

-include $(NEW_DEPS)

src/exesrc/%.o: src/exesrc/%.c
	$(CC) -I$(LIB_INTERFACE) $(CFLAGS) -c $< -o $@

src/exesrc/xtc: src/exesrc/xtc_cmd.o
	$(LD) $(LDFLAGS) -ldl $^ -o $@
