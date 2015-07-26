NEW_C_SRCS  := $(CWD)/xtc_cmd.c
NEW_DEPS    := $(NEW_C_SRCS:.c=.d)

C_SRCS      := $(C_SRCS) $(NEW_C_SRCS)
OBJS        := $(OBJS) $(NEW_C_SRCS:.c=.o)
DEPS        := $(DEPS) $(NEW_DEPS)
BINARIES    := $(BINARIES) $(CWD)/xtc
EXECUTABLES := $(EXECUTABLES) $(CWD)/xtc

-include $(NEW_DEPS)

$(CWD)/%.o: $(CWD)/%.c
	$(CC) -I$(LIB_INTERFACE) $(CFLAGS) -c $< -o $@

$(CWD)/xtc: $(CWD)/xtc_cmd.o
	$(LD) $(LDFLAGS) -ldl $^ -o $@
