ifndef TOPLEVELWD
include $(dir $(lastword $(MAKEFILE_LIST)))../rules.mk
.DEFAULT_GOAL := $(LIB_PATH)
else

LIB_INTERFACE := $(CWD)interface

$(call enter,src)

endif
