ifndef root
    include $(dir $(lastword $(MAKEFILE_LIST)))../Makefile
    $(call set_default_goal,CMD)
else
    TP_LINK_CMD := -ldl
    $(call make_exe,CMD,xtc)
endif
