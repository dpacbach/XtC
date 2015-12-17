ifndef TOPLEVELWD
include $(dir $(lastword $(MAKEFILE_LIST)))../makefile
$(call set_default_goal,TEST)
else
LOCATION := TEST
$(call compile_exe,xtctest)
endif
