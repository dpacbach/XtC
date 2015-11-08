$(call assert,$(TOPLEVELWD),TOPLEVELWD not defined!)

location_file := $(TOPLEVELWD).location
location      := $(abspath $(PWD))

update_location = $(shell echo $(location) > $(location_file))

ifeq ($(wildcard $(location_file)),)
    $(call update_location)
endif

last_wd := $(shell cat $(location_file))
ifneq ($(last_wd),$(location))
    $(info Last make command was run from $(last_wd))
    $(info Auto-dependencies need to be relocated!)
    $(shell $(CWD)scripts/reloc.sh $(abspath $(TOPLEVELWD)) 1>&2)
    $(call update_location)
endif
