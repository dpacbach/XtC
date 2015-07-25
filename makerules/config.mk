CC := gcc

CFLAGS := -std=c99
CFLAGS_DEBUG   := -g
CFLAGS_RELEASE := -O2
CFLAGS_LIB     := -fPIC

ifdef OPT
CFLAGS += $(CFLAGS_RELEASE)
else
CFLAGS += $(CFLAGS_DEBUG)
endif

LD := gcc
LDFLAGS :=
LDFLAGS_LIB := -shared

LIBXML2_INCLUDE := /usr/include/libxml2
LIBXML2_LIB     := /usr/lib64/libxml2.so

INSTALL_PREFIX := $(HOME)/tmp
