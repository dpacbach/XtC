###############################################################################
# This is where all of the top-level, project-specific information is supplied.

CFLAGS         += -MMD -MP -std=c99
CXXFLAGS       +=
CFLAGS_DEBUG   += -g -ggdb -gstabs
CFLAGS_RELEASE += -O2
CFLAGS_LIB     += -fPIC

ifdef OPT
    CFLAGS += $(CFLAGS_RELEASE)
else
    CFLAGS += $(CFLAGS_DEBUG)
endif

LD := gcc
LDFLAGS :=
LDFLAGS_LIB := -shared

INSTALL_PREFIX := $(HOME)/tmp

ifeq ($(OS),OSX)
    LIBXML2_INCLUDE := /opt/local/include/libxml2
    CFLAGS          += -DOS_OSX
else
    LIBXML2_INCLUDE := /usr/include/libxml2
    CFLAGS          += -DOS_LINUX
endif

# This variable controls whether rule commands are echoed
# or suppressed infavor of more terse log output.
#V ?= YES

###############################################################################
# Dependency info

TEST_deps := LIB
LIB_deps  := LIB_INT

# This is the location holding the main runnable program
MAIN_PROGRAM := CMD
