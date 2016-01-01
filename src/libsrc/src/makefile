ifndef TOPLEVELWD
    include $(dir $(lastword $(MAKEFILE_LIST)))../makefile
    $(call set_default_goal,LIB)
else
    $(call make_so,LIB,xtc)
endif
