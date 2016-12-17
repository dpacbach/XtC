ifndef root
    include $(dir $(lastword $(MAKEFILE_LIST)))../Makefile
    $(call set_default_goal,LIB_INT)
else
    $(call set_location,LIB_INT)
endif
