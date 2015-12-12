ifndef TOPLEVELWD
include $(dir $(lastword $(MAKEFILE_LIST)))../Makefile
else

LIB_NAME      := libxtc.so
CMD_NAME      := xtc
TEST_NAME     := xtctest

# In general, must enter in order of dependencies.
locations := libsrc  \
             exesrc  \
             testsrc

$(call enter_all,$(locations))

endif
