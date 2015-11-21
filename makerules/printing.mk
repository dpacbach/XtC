# This make file controls echoing/logging output during
# the make run.

ifdef SHOW_RULES
    at :=
    rule=
else
    at := @
    rule = @echo $1
endif

print_compile = $(call rule,"compiling $<")
print_link    = $(call rule,"  linking $@")
print_run     = $(call rule,"  running $@")
