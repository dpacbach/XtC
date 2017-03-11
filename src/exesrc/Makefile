ifndef root
    include $(dir $(lastword $(MAKEFILE_LIST)))../Makefile
else
    TP_LINK_CMD := -ldl
    $(call make_exe,CMD,xtc)
endif
