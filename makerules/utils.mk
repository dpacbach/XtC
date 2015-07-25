TURNOFF_COLORMAKE := @echo "COLORMAKE_BEGIN_RUN"

print-%:
	@echo $*=$(value $*)=$($*)

.PHONY: print-%
