define _compile_exe
EXE_NAME := $1

LOCATION_$(LOCATION) := $$(relCWD)
EXE_NAME_$(LOCATION) := $$(relCWD)$$(EXE_NAME)

NEW_C_SRCS  := $$(wildcard $$(relCWD)*.c)
NEW_OBJS    := $$(NEW_C_SRCS:.c=.o)
NEW_DEPS    := $$(NEW_C_SRCS:.c=.d)

C_SRCS      := $$(C_SRCS) $$(NEW_C_SRCS)
OBJS        := $$(OBJS) $$(NEW_OBJS)
DEPS        := $$(DEPS) $$(NEW_DEPS)
BINARIES    := $$(BINARIES) $$(relCWD)$$(EXE_NAME)
EXECUTABLES := $$(EXECUTABLES) $$(relCWD)$$(EXE_NAME)

-include $$(NEW_DEPS)

# Here we put a static pattern rule otherwise when
# we run make out of the folder containing this make
# file the relCWD will be empty and so the pattern
# would match any object file and cause this rule
# to be used to compile files in other folders which
# is not correct.
$$(NEW_OBJS): $$(relCWD)%.o: $$(relCWD)%.c
	$$(print_compile) $$(CC) $$(TPN_INCLUDES_$(LOCATION)) $$(INCLUDES_$(LOCATION)) $$(CFLAGS) -c $$< -o $$@

$$(relCWD)$$(EXE_NAME): $$(NEW_OBJS) $$(LINK_$(LOCATION))
	$$(print_link) $$(LD) $$(LDFLAGS) $$(TP_LINK_$(LOCATION)) $$^ -o $$@

DEFAULT_GOAL_$(LOCATION) := $$(relCWD)$$(EXE_NAME)
endef

compile_exe = $(eval $(call _compile_exe,$1))
