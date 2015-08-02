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

print-%:
	@echo $*=$(value $*) \($($*)\)

.PHONY: print-%
