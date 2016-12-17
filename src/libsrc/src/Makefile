ifndef root
    include $(dir $(lastword $(MAKEFILE_LIST)))../Makefile
    $(call set_default_goal,LIB)
else
    TP_INCLUDES_LIB := -I$(LIBXML2_INCLUDE)
    TP_LINK_LIB     := -lxml2
    $(call make_so,LIB,xtc)
endif
