ifndef TOPLEVELWD
include $(dir $(lastword $(MAKEFILE_LIST)))../Makefile
else

LIB_NAME      := libxtc.so
CMD_NAME      := xtc
TEST_NAME     := xtctest

# Must enter in order of dependencies.
#
# Note: there seems to be some problems with this build system's
# use of relative path's for targets (relative to the PWD).  When
# compiling a file in a different directory from a directory which
# has a makefile with a compile rule, the target for that rule will
# have either no slashes or will have only a ./ at the front.  In
# that case make seems to want to match anything to it.  So this means
# that you can't compile a file in one directory from another in
# general.  When running make in one folder it may cause files in
# other folders to be compiled.  However, this seems like it will
# work properly because if files in other folders are compiled as
# prerequisites then that means that they should appear first in
# the list below and hence make will choose them if there is an
# ambiguity.  Also, make should not be confused between two sets
# of build rules which are both outside the current directory since
# they should both have nontrivial paths.  The above is not
# guaranteed to be right.
#
# The ordering of the list below also comes about because some
# make files need symbols that are defined in other make modules.
$(call enter,libsrc)
$(call enter,exesrc)
$(call enter,testsrc)

endif
