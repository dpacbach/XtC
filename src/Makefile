ifndef root
    include $(dir $(lastword $(MAKEFILE_LIST)))../Makefile
else
    # In general, must enter in order of dependencies.
    locations := libsrc exesrc testsrc
    $(call enter_all,$(locations))
endif
