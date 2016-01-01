ifndef TOPLEVELWD
    include $(dir $(lastword $(MAKEFILE_LIST)))../makefile
    $(call set_default_goal,CMD)
else
    $(call make_exe,CMD,xtc)
endif
