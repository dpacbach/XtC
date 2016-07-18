###############################################################################
# This is where all of the top-level, project-specific information is supplied.

CFLAGS         += -MMD -MP -std=c99
CXXFLAGS       += $(CFLAGS)

CFLAGS_DEBUG   += $(CXXFLAGS) -g -ggdb
CFLAGS_RELEASE += $(CXXFLAGS) -O2

CFLAGS_LIB     += -fPIC

ifdef OPT
    CXXFLAGS_TO_USE += $(CFLAGS_RELEASE)
else
    CXXFLAGS_TO_USE += $(CFLAGS_DEBUG)
endif

CC  := gcc
CXX := gcc
LD  := gcc

LDFLAGS     :=
LDFLAGS_LIB := $(LDFLAGS) -shared

INSTALL_PREFIX := $(HOME)/tmp

ifeq ($(OS),OSX)
    LIBXML2_INCLUDE := /opt/local/include/libxml2
else
    LIBXML2_INCLUDE := /usr/include/libxml2
endif

TEST.deps := LIB
LIB.deps  := LIB_INT

# This is the location holding the main runnable program
MAIN_PROGRAM := CMD
