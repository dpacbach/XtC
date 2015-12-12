ifndef TOPLEVELWD
include $(dir $(lastword $(MAKEFILE_LIST)))../makefile
.DEFAULT_GOAL := $(DEFAULT_GOAL_TEST)
else

LOCATION_TEST := $(relCWD)

NEW_C_SRCS  := $(wildcard $(relCWD)*.c)
NEW_OBJS    := $(NEW_C_SRCS:.c=.o)
NEW_DEPS    := $(NEW_C_SRCS:.c=.d)

TEST_CMD_PATH := $(relCWD)$(TEST_NAME)

C_SRCS      := $(C_SRCS) $(NEW_C_SRCS)
OBJS        := $(OBJS) $(NEW_OBJS)
DEPS        := $(DEPS) $(NEW_DEPS)
BINARIES    := $(BINARIES) $(TEST_CMD_PATH)

-include $(NEW_DEPS)

# Here we put a static pattern rule otherwise when
# we run make out of the folder containing this make
# file the relCWD will be empty and so the pattern
# would match any object file and cause this rule
# to be used to compile files in other folders which
# is not correct.
$(NEW_OBJS): $(relCWD)%.o: $(relCWD)%.c
	$(call assert_target_location,$(LOCATION_TEST))
	$(print_compile)
	$(at)$(CC) $(INCLUDES_TEST) $(CFLAGS) -c $< -o $@

$(relCWD)$(TEST_NAME): $(NEW_C_SRCS:.c=.o) $(LIB_PATH)
	$(call assert_target_location,$(LOCATION_TEST))
	$(print_link)
	$(at)$(LD) $(LDFLAGS) $^ -o $@

DEFAULT_GOAL_TEST := $(relCWD)$(TEST_NAME)

endif
