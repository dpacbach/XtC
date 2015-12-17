ifndef TOPLEVELWD
include $(dir $(lastword $(MAKEFILE_LIST)))../makefile
$(call set_default_goal,CMD)
else
LOCATION := CMD
$(call compile_exe,xtc)
endif
