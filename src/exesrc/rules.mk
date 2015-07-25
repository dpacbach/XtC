NEW_C_SRCS := src/exesrc/xtc_cmd.c

C_SRCS      := $(C_SRCS) $(NEW_C_SRCS)
OBJS        := $(OBJS) $(NEW_C_SRCS:.c=.o)
BINARIES    := $(BINARIES) src/exesrc/xtc
EXECUTABLES := $(EXECUTABLES) src/exesrc/xtc

src/exesrc/%.o: src/exesrc/%.c
	$(CC) -I$(LIB_INTERFACE) $(CFLAGS) -c $< -o $@

src/exesrc/xtc: src/exesrc/xtc_cmd.o
	$(LD) $(LDFLAGS) -ldl $^ -o $@
