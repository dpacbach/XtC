# This file will do anything can can only be done after the source
# tree has been traversed.

# Check to make sure all of the locations have been defined.
assert_loc = $(call assert,$(LOCATION_$1),"LOCATION_$(1) not defined")
$(call map,assert_loc,$(ALL_LOCATIONS))
