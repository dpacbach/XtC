ifndef TOPLEVELWD
include $(dir $(lastword $(MAKEFILE_LIST)))../makefile
.DEFAULT_GOAL := $(DEFAULT_GOAL_CMD)
else

LOCATION_CMD := $(relCWD)

NEW_C_SRCS  := $(wildcard $(relCWD)*.c)
NEW_DEPS    := $(NEW_C_SRCS:.c=.d)

CMD_PATH := $(relCWD)$(CMD_NAME)

C_SRCS      := $(C_SRCS) $(NEW_C_SRCS)
OBJS        := $(OBJS) $(NEW_C_SRCS:.c=.o)
DEPS        := $(DEPS) $(NEW_DEPS)
BINARIES    := $(BINARIES) $(CMD_PATH)
EXECUTABLES := $(EXECUTABLES) $(CMD_PATH)

-include $(NEW_DEPS)

$(relCWD)%.o: targetCWD := $(relCWD)
$(relCWD)%.o: $(relCWD)%.c
	$(call assert_target_location)
	$(print_compile)
	$(at)$(CC) $(INCLUDES_CMD) $(CFLAGS) -c $< -o $@

$(relCWD)$(CMD_NAME): targetCWD := $(relCWD)
$(relCWD)$(CMD_NAME): $(NEW_C_SRCS:.c=.o)
	$(call assert_target_location)
	$(print_link)
	$(at)$(LD) $(LDFLAGS) -ldl $^ -o $@

DEFAULT_GOAL_CMD := $(relCWD)$(CMD_NAME)

endif
