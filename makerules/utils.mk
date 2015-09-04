TURNOFF_COLORMAKE := @echo "COLORMAKE_BEGIN_RUN"

define enterimpl
    CWD_SP := $$(CWD_SP)_x
    $$(CWD_SP) := $$(CWD)
    CWD := $$(CWD)$1/
    #$$(info Entering $$(CWD))
    include $$(CWD)/makefile
    #$$(info Leaving $$(CWD))
    CWD := $$($$(CWD_SP))
    CWD_SP := $$(patsubst %_x,%,$$(CWD_SP))
endef

enter = $(eval $(call enterimpl,$1))

# Apply the given function to each element of the list and
# form a new list with the results.
map = $(foreach i,$2,$(call $1,$(i)))

# Single quotes so that bash doesn't try to expand any left-over
# dollar signs
print-%:
	@echo '$*=$(value $*) ($($*))'

assert = $(if $1,,$(error $2))

.PHONY: print-%
