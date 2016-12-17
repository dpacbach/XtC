# ===============================================================
# This is where all of the top-level, project-specific
# information is supplied.
# ===============================================================
ENABLE_BIN_FOLDER = 1

CXXFLAGS += -DSO_EXT=$(SO_EXT)

ifeq ($(OS),OSX)
    LIBXML2_INCLUDE := /opt/local/include/libxml2
else
    LIBXML2_INCLUDE := /usr/include/libxml2
endif

TEST.deps := LIB
CMD.deps  := LIB_INT
LIB.deps  := LIB_INT

# ===============================================================
# Here we traverse the source tree
# ===============================================================
$(call enter,src)
