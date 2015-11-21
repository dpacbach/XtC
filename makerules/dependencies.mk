ALL_LOCATIONS := CMD     \
                 TEST    \
                 LIB     \
                 LIB_INT

#assert_headers = $(call assert,$(LOCATION_$1),"LOCATION_$1 NOT DEFINED")
#$(call map,assert_headers,$(ALL_LOCATIONS))

DEPS_CMD     := LIB_INT
DEPS_TEST    := LIB_INT
DEPS_LIB     := LIB_INT
DEPS_LIB_INT :=

include_flag  = -I$(if $(LOCATION_$1),$(LOCATION_$1),.)
include_flags = $(call map,include_flag,$1 $(DEPS_$1))

define calc_include
    $(eval INCLUDES_$1 = $$(call include_flags,$1))
endef

$(call map,calc_include,$(ALL_LOCATIONS))
