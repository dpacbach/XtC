ifndef TOPLEVELWD
    include $(dir $(lastword $(MAKEFILE_LIST)))../makefile
    $(call set_default_goal,LIB_INT)
else
    $(call set_location,LIB_INT)
endif
