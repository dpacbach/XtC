ALL_LOCATIONS := CMD TEST LIB LIB_INT

#assert_headers = $(call assert,$(LOCATION_$1),"LOCATION_$1 NOT DEFINED")
#$(call map,assert_headers,$(ALL_LOCATIONS))

DEPS_CMD     = LIB_INT
DEPS_TEST    = LIB_INT
DEPS_LIB     = LIB_INT
DEPS_LIB_INT =

include_flag = -I$(LOCATION_$1)

#include_flags = $(eval INCLUDES_$1=$(call map,include_flag,$1 $(DEPS_$1)))
include_flags = $(call map,include_flag,$1 $(DEPS_$1))

#$(call map,include_flags,$(ALL_LOCATIONS))
INCLUDES_CMD  = $(call include_flags,$(DEPS_CMD))
INCLUDES_TEST = $(call include_flags,$(DEPS_TEST))
INCLUDES_LIB  = $(call include_flags,$(DEPS_LIB))

#$(foreach i,$(ALL_LOCATIONS),$(info INCLUDES_$(i)=$(INCLUDES_$(i))))
