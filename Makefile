.DEFAULT_GOAL := all

CWD := $(dir $(lastword $(MAKEFILE_LIST)))
TOPLEVELWD := $(CWD)

# This is a special file that has the traversal function
include $(CWD)makerules/enter.mk

# Load all extra makerules
$(call enter,makerules)
# Now traverse the source tree
$(call enter,src)

include $(CWS)makerules/postsrc.mk

all: $(LIB_BINARY) $(CMD_BINARY) $(TEST_BINARY)

test: $(TEST_BINARY)
	$(at)$(TURNOFF_COLORMAKE)
	$(at)LD_LIBRARY_PATH=$(dir $(LIB_BINARY)) ./$(TEST_BINARY)

# Need to add the LIB_BINARY dependency here because CMD_BINARY
# has a dependency on it only at runtime.
runcmd: $(LIB_BINARY) $(CMD_BINARY)
	$(at)$(TURNOFF_COLORMAKE)
	$(at)LD_LIBRARY_PATH=$(dir $(LIB_BINARY)) ./$(CMD_BINARY)

install: $(LIB_BINARY) $(CMD_BINARY)
	$(at)$(TURNOFF_COLORMAKE)
	$(at)echo "Installing to $(INSTALL_PREFIX)"
	$(at)mkdir -p $(INSTALL_PREFIX)/bin
	$(at)mkdir -p $(INSTALL_PREFIX)/lib
	$(at)mkdir -p $(INSTALL_PREFIX)/include
	$(at)cp $(LIBRARIES) $(INSTALL_PREFIX)/lib
	$(at)chmod u+x $(EXECUTABLES)
	$(at)cp $(EXECUTABLES) $(INSTALL_PREFIX)/bin
	$(at)cp -r $(LOCATION_LIB_INT)/* $(INSTALL_PREFIX)/include

clean:
	$(at)-rm -f $(if $(at),-v ,)$(OBJS) $(BINARIES) $(DEPS)
	@-rm -f $(location_file)

.PHONY: all test runcmd install clean
