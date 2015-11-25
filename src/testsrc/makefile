ifndef TOPLEVELWD
include $(dir $(lastword $(MAKEFILE_LIST)))../makefile
.DEFAULT_GOAL := $(DEFAULT_GOAL_TEST)
else

LOCATION_TEST := $(relCWD)

NEW_C_SRCS  := $(wildcard $(relCWD)*.c)
NEW_DEPS    := $(NEW_C_SRCS:.c=.d)

TEST_CMD_PATH := $(relCWD)$(TEST_NAME)

C_SRCS      := $(C_SRCS) $(NEW_C_SRCS)
OBJS        := $(OBJS) $(NEW_C_SRCS:.c=.o)
DEPS        := $(DEPS) $(NEW_DEPS)
BINARIES    := $(BINARIES) $(TEST_CMD_PATH)

-include $(NEW_DEPS)

$(relCWD)%.o: $(relCWD)%.c $(ALL_MAKEFILES)
	$(CC) $(INCLUDES_TEST) $(CFLAGS) -c $< -o $@

$(relCWD)$(TEST_NAME): $(NEW_C_SRCS:.c=.o) $(LIB_PATH)
	$(LD) $(LDFLAGS) $^ -o $@

DEFAULT_GOAL_TEST := $(relCWD)$(TEST_NAME)

endif
