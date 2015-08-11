.DEFAULT_GOAL := all

CWD := $(dir $(lastword $(MAKEFILE_LIST)))
TOPLEVELWD := $(CWD)

CWD := $(CWD)makerules/
include $(CWD)makefile
CWD := $(TOPLEVELWD)

$(call enter,src)

all: $(LIB_PATH) $(CMD_PATH) $(TEST_CMD_PATH)

test: $(TEST_CMD_PATH)
	$(TURNOFF_COLORMAKE)
	LD_LIBRARY_PATH=$(dir $(LIB_PATH)) ./$(TEST_CMD_PATH)

runcmd: $(CMD_PATH)
	$(TURNOFF_COLORMAKE)
	LD_LIBRARY_PATH=$(dir $(LIB_PATH)) ./$(CMD_PATH)

install: $(LIB_PATH) $(CMD_PATH)
	$(TURNOFF_COLORMAKE)
	@echo "Installing to $(INSTALL_PREFIX)"
	mkdir -p $(INSTALL_PREFIX)/bin
	mkdir -p $(INSTALL_PREFIX)/lib
	mkdir -p $(INSTALL_PREFIX)/include
	cp $(LIBRARIES) $(INSTALL_PREFIX)/lib
	chmod u+x $(EXECUTABLES)
	cp $(EXECUTABLES) $(INSTALL_PREFIX)/bin
	cp -r $(LIB_INTERFACE)/* $(INSTALL_PREFIX)/include

clean:
	-rm $(OBJS)
	-rm $(BINARIES)
	-rm $(DEPS)

.PHONY: all test runcmd install clean
