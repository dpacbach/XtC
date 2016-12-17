ifndef root
    include $(dir $(lastword $(MAKEFILE_LIST)))../Makefile
    $(call set_default_goal,TEST)
else
    $(call make_exe,TEST,xtctest)
endif
