$(call assert,$(TOPLEVELWD),TOPLEVELWD not defined!)

reloc_sh      := $(CWD)scripts/reloc.sh
location_file := $(TOPLEVELWD).location
top_wd        := $(abspath $(TOPLEVELWD))
new_wd        := $(abspath $(PWD))

update_location = $(shell echo $(new_wd) > $(location_file))

ifeq ($(wildcard $(location_file)),)
    $(call update_location)
endif

last_wd := $(shell cat $(location_file))

ifneq ($(last_wd),$(new_wd))
    $(info Last make command was run from $(last_wd))
    $(info Auto-dependencies need to be relocated!)
    $(shell $(reloc_sh) $(top_wd) $(last_wd) $(new_wd) 1>&2)
    $(call update_location)
endif
