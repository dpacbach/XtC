LIB_INTERFACE := src/libsrc/interface
LIB_NAME      := src/libsrc/src/libxtc.so
LIB_FOLDER    := $(dir $(LIB_NAME))
CMD_NAME      := src/exesrc/xtc
TEST_NAME     := src/testsrc/xtctest

include src/exesrc/rules.mk
include src/libsrc/src/rules.mk
include src/testsrc/rules.mk
