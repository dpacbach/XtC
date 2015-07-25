.DEFAULT_GOAL := all

include makerules/config.mk
include makerules/utils.mk

include src/rules.mk

all: $(LIB_NAME) $(CMD_NAME)

test: $(TEST_BINARY)
	$(TURNOFF_COLORMAKE)
	LD_LIBRARY_PATH=$(LIB_FOLDER) ./$(TEST_BINARY)

runcmd: $(CMD_NAME)
	$(TURNOFF_COLORMAKE)
	LD_LIBRARY_PATH=$(LIB_FOLDER) ./$(CMD_NAME)

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

.PHONY: all test runcmd install clean
