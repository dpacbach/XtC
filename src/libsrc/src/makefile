ifndef TOPLEVELWD
include $(dir $(lastword $(MAKEFILE_LIST)))../makefile
.DEFAULT_GOAL := $(DEFAULT_GOAL_LIBRARY)
else

LOCATION_LIB := $(relCWD)

NEW_C_SRCS := $(wildcard $(relCWD)*.c)
NEW_OBJS   := $(NEW_C_SRCS:.c=.o)
NEW_DEPS   := $(NEW_C_SRCS:.c=.d)

LIB_PATH := $(relCWD)$(LIB_NAME)

C_SRCS    := $(C_SRCS) $(NEW_C_SRCS)
OBJS      := $(OBJS) $(NEW_OBJS)
DEPS      := $(DEPS) $(NEW_DEPS)
BINARIES  := $(BINARIES) $(LIB_PATH)
LIBRARIES := $(LIBRARIES) $(LIB_PATH)

-include $(NEW_DEPS)

# Here we put a static pattern rule otherwise when
# we run make out of the folder containing this make
# file the relCWD will be empty and so the pattern
# would match any object file and cause this rule
# to be used to compile files in other folders which
# is not correct.
$(NEW_OBJS): $(relCWD)%.o: $(relCWD)%.c
	$(call assert_target_location,$(LOCATION_LIB))
	$(print_compile)
	$(at)$(CC) $(INCLUDES_LIB) -I$(LIBXML2_INCLUDE) $(CFLAGS_LIB) $(CFLAGS) -c $< -o $@

$(relCWD)$(LIB_NAME): $(NEW_C_SRCS:.c=.o)
	$(call assert_target_location,$(LOCATION_LIB))
	$(print_link)
	$(at)$(LD) $(LDFLAGS_LIB) $(LDFLAGS) $(LIBXML2_LIB) $^ -o $@

DEFAULT_GOAL_LIBRARY := $(relCWD)$(LIB_NAME)

endif
