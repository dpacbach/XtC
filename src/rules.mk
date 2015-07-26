LIB_INTERFACE := src/libsrc/interface
LIB_NAME      := src/libsrc/src/libxtc.so
LIB_FOLDER    := $(dir $(LIB_NAME))
CMD_NAME      := src/exesrc/xtc
TEST_NAME     := src/testsrc/xtctest

CWD := src
$(call enter,exesrc)
$(call enter,libsrc)
$(call enter,testsrc)
