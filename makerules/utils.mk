TURNOFF_COLORMAKE := @echo "COLORMAKE_BEGIN_RUN"

define enterimpl
    CWD := $$(CWD)/$1
    #$$(info Entering $$(CWD))
    include $$(CWD)/rules.mk
    CWD := $$(dir $$(CWD))
    CWD := $$(patsubst %/,%,$$(CWD))
endef

enter = $(eval $(call enterimpl,$1))

print-%:
	@echo $*=$(value $*)=$($*)

.PHONY: print-%
