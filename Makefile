.DEFAULT_GOAL := full

CWD := $(dir $(lastword $(MAKEFILE_LIST)))
TOPLEVELWD := $(CWD)

# This is a special file that has the traversal function
include $(CWD)makerules/enter.mk

# Load all extra makerules
$(call enter,makerules)
# Now traverse the source tree
$(call enter,src)

full: $(LIB_PATH) $(CMD_PATH) $(TEST_CMD_PATH)

test: $(TEST_CMD_PATH)
	$(at)$(TURNOFF_COLORMAKE)
	$(at)LD_LIBRARY_PATH=$(dir $(LIB_PATH)) ./$(TEST_CMD_PATH)

runcmd: $(CMD_PATH)
	$(at)$(TURNOFF_COLORMAKE)
	$(at)LD_LIBRARY_PATH=$(dir $(LIB_PATH)) ./$(CMD_PATH)

install: $(LIB_PATH) $(CMD_PATH)
	$(at)$(TURNOFF_COLORMAKE)
	$(at)echo "Installing to $(INSTALL_PREFIX)"
	$(at)mkdir -p $(INSTALL_PREFIX)/bin
	$(at)mkdir -p $(INSTALL_PREFIX)/lib
	$(at)mkdir -p $(INSTALL_PREFIX)/include
	$(at)cp $(LIBRARIES) $(INSTALL_PREFIX)/lib
	$(at)chmod u+x $(EXECUTABLES)
	$(at)cp $(EXECUTABLES) $(INSTALL_PREFIX)/bin
	$(at)cp -r $(LIB_INTERFACE)/* $(INSTALL_PREFIX)/include

clean:
	$(at)-rm -f $(if $(at),-v ,)$(OBJS) $(BINARIES) $(DEPS)
	@-rm -f $(location_file)

.PHONY: all test runcmd install clean
