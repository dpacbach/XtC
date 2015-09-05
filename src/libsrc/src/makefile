ifndef TOPLEVELWD
include $(dir $(lastword $(MAKEFILE_LIST)))../makefile
.DEFAULT_GOAL := $(DEFAULT_GOAL_LIBRARY)
else

LOCATION_LIB := $(CWD)

NEW_C_SRCS := $(wildcard $(CWD)*.c)
NEW_DEPS   := $(NEW_C_SRCS:.c=.d)

LIB_PATH := $(CWD)$(LIB_NAME)

C_SRCS    := $(C_SRCS) $(NEW_C_SRCS)
OBJS      := $(OBJS) $(NEW_C_SRCS:.c=.o)
DEPS      := $(DEPS) $(NEW_DEPS)
BINARIES  := $(BINARIES) $(LIB_PATH)
LIBRARIES := $(LIBRARIES) $(LIB_PATH)

-include $(NEW_DEPS)

#$(CWD)%.o: CWD_L := $(CWD)
$(CWD)%.o: $(CWD)%.c
	$(CC) $(INCLUDES_LIB) -I$(LIBXML2_INCLUDE) $(CFLAGS_LIB) $(CFLAGS) -c $< -o $@

$(CWD)$(LIB_NAME): $(NEW_C_SRCS:.c=.o)
	$(LD) $(LDFLAGS_LIB) $(LDFLAGS) $(LIBXML2_LIB) $^ -o $@
	strip $@

DEFAULT_GOAL_LIBRARY := $(CWD)$(LIB_NAME)

endif
