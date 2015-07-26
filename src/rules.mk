LIB_NAME      := libxtc.so
CMD_NAME      := xtc
TEST_NAME     := xtctest

# Must enter in order of dependencies
$(call enter,libsrc)
$(call enter,exesrc)
$(call enter,testsrc)
