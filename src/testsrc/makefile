ifndef TOPLEVELWD
    include $(dir $(lastword $(MAKEFILE_LIST)))../makefile
    $(call set_default_goal,TEST)
else
    $(call make_exe,TEST,xtctest)
endif
