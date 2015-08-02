ifndef TOPLEVELWD
include $(dir $(lastword $(MAKEFILE_LIST)))../makefile
.DEFAULT_GOAL := $(TEST_CMD_PATH)
else

NEW_C_SRCS  := $(wildcard $(CWD)*.c)
NEW_DEPS    := $(NEW_C_SRCS:.c=.d)

TEST_CMD_PATH := $(CWD)$(TEST_NAME)

C_SRCS      := $(C_SRCS) $(NEW_C_SRCS)
OBJS        := $(OBJS) $(NEW_C_SRCS:.c=.o)
DEPS        := $(DEPS) $(NEW_DEPS)
BINARIES    := $(BINARIES) $(TEST_CMD_PATH)

-include $(NEW_DEPS)

$(CWD)%.o: $(CWD)%.c
	$(CC) -I$(LIB_INTERFACE) $(CFLAGS) -c $< -o $@

$(CWD)$(TEST_NAME): $(NEW_C_SRCS:.c=.o) $(LIB_PATH)
	$(LD) $(LDFLAGS) $^ -o $@

endif
