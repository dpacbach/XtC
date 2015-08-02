ifndef TOPLEVELWD
include $(dir $(lastword $(MAKEFILE_LIST)))../rules.mk
.DEFAULT_GOAL := $(CMD_PATH)
else

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
	$(CC) -I$(LIB_INTERFACE) $(CFLAGS) -c $< -o $@

$(CWD)$(CMD_NAME): $(NEW_C_SRCS:.c=.o)
	$(LD) $(LDFLAGS) -ldl $^ -o $@

endif
