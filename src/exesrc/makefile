ifndef TOPLEVELWD
include $(dir $(lastword $(MAKEFILE_LIST)))../makefile
.DEFAULT_GOAL := $(DEFAULT_GOAL_CMD)
else

LOCATION_CMD := $(CWD)

NEW_C_SRCS  := $(wildcard $(CWD)*.c)
NEW_DEPS    := $(NEW_C_SRCS:.c=.d)

CMD_PATH := $(CWD)$(CMD_NAME)

C_SRCS      := $(C_SRCS) $(NEW_C_SRCS)
OBJS        := $(OBJS) $(NEW_C_SRCS:.c=.o)
DEPS        := $(DEPS) $(NEW_DEPS)
BINARIES    := $(BINARIES) $(CMD_PATH)
EXECUTABLES := $(EXECUTABLES) $(CMD_PATH)

-include $(NEW_DEPS)

$(CWD)%.o: $(CWD)%.c
	$(CC) $(INCLUDES_CMD) $(CFLAGS) -c $< -o $@

$(CWD)$(CMD_NAME): $(NEW_C_SRCS:.c=.o)
	$(LD) $(LDFLAGS) -ldl $^ -o $@

DEFAULT_GOAL_CMD := $(CWD)$(CMD_NAME)

endif
