ALL_MAKEFILES := $(ALL_MAKEFILES) $(lastword $(MAKEFILE_LIST))

# These need to be in a certain order

include $(CWD)gmsl/gmsl

TO_INCLUDE := $(CWD)config.mk       \
              $(CWD)utils.mk        \
              $(CWD)dependencies.mk \
              $(CWD)reloc.mk

ALL_MAKEFILES := $(ALL_MAKEFILES) $(TO_INCLUDE)

include $(TO_INCLUDE)

makefiles_change: $(ALL_MAKEFILES)
	@echo Rebuilding due to makefile change
