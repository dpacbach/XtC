.DEFAULT_GOAL := all
#.DELETE_ON_ERROR

THIS_MAKEFILE := $(lastword $(MAKEFILE_LIST))
ALL_MAKEFILES := $(ALL_MAKEFILES) $(THIS_MAKEFILE)
CWD := $(dir $(THIS_MAKEFILE))
TOPLEVELWD := $(CWD)

# This is a special file that has the traversal function
include $(CWD)makerules/enter.mk
ALL_MAKEFILES := $(ALL_MAKEFILES) $(CWD)makerules/enter.mk

# Do recursive wildcard to find all makefiles and put in
# ALL_MAKEFILES

# Load all extra makerules
$(call enter,makerules)
# Now traverse the source tree
$(call enter,src)

all: $(LIB_PATH) $(CMD_PATH) $(TEST_CMD_PATH) $(ALL_MAKEFILES)

test: $(TEST_CMD_PATH)
	$(TURNOFF_COLORMAKE)
	LD_LIBRARY_PATH=$(dir $(LIB_PATH)) ./$(TEST_CMD_PATH)

runcmd: $(CMD_PATH)
	$(TURNOFF_COLORMAKE)
	LD_LIBRARY_PATH=$(dir $(LIB_PATH)) ./$(CMD_PATH)

install: $(LIB_PATH) $(CMD_PATH)
	$(TURNOFF_COLORMAKE)
	@echo "Installing to $(INSTALL_PREFIX)"
	@mkdir -p $(INSTALL_PREFIX)/bin
	@mkdir -p $(INSTALL_PREFIX)/lib
	@mkdir -p $(INSTALL_PREFIX)/include
	@cp $(LIBRARIES) $(INSTALL_PREFIX)/lib
	@chmod u+x $(EXECUTABLES)
	@cp $(EXECUTABLES) $(INSTALL_PREFIX)/bin
	@cp -r $(LIB_INTERFACE)/* $(INSTALL_PREFIX)/include

clean:
	@-rm -f -v $(OBJS) $(BINARIES) $(DEPS) $(location_file)

.PHONY: all test runcmd install clean makefiles_change
