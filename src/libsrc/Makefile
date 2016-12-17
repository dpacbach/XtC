ifndef root
    include $(dir $(lastword $(MAKEFILE_LIST)))../Makefile
    $(call set_default_goal,LIB)
else
    $(call enter,interface)
    $(call enter,src)
endif
