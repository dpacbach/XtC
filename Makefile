.DEFAULT_GOAL := all

include makerules/config.mk
include makerules/utils.mk

CWD := .
$(call enter,src)

all: $(LIB_PATH) $(CMD_PATH) $(TEST_CMD_PATH)

test: $(TEST_CMD_PATH)
	$(TURNOFF_COLORMAKE)
	LD_LIBRARY_PATH=$(dir $(LIB_PATH)) ./$(TEST_CMD_PATH)

runcmd: $(CMD_PATH)
	$(TURNOFF_COLORMAKE)
	LD_LIBRARY_PATH=$(dir $(LIB_PATH)) ./$(CMD_PATH)

install: all
	$(TURNOFF_COLORMAKE)
	@echo "Installing to $(INSTALL_PREFIX)"
	mkdir -p $(INSTALL_PREFIX)/bin
	mkdir -p $(INSTALL_PREFIX)/lib
	cp $(LIBRARIES) $(INSTALL_PREFIX)/lib
	cp $(EXECUTABLES) $(INSTALL_PREFIX)/bin
	chmod u+x $(EXECUTABLES)

clean:
	-rm $(OBJS)
	-rm $(BINARIES)
	-rm $(DEPS)

.PHONY: all test runcmd install clean
