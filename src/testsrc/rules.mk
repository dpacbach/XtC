NEW_C_SRCS  := $(CWD)/xtctest.c
NEW_DEPS    := $(NEW_C_SRCS:.c=.d)

C_SRCS      := $(C_SRCS) $(NEW_C_SRCS)
OBJS        := $(OBJS) $(NEW_C_SRCS:.c=.o)
DEPS        := $(DEPS) $(NEW_DEPS)
BINARIES    := $(BINARIES) $(CWD)/xtctest

-include $(NEW_DEPS)

$(CWD)/%.o: $(CWD)/%.c
	$(CC) -I$(LIB_INTERFACE) $(CFLAGS) -c $< -o $@

$(CWD)/xtctest: $(CWD)/xtctest.o $(LIB_NAME)
	$(LD) $(LDFLAGS) $^ -o $@
