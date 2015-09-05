TURNOFF_COLORMAKE := @echo "COLORMAKE_BEGIN_RUN"

# Apply the given function to each element of the list and
# form a new list with the results.
map = $(foreach i,$2,$(call $1,$(i)))

# Single quotes so that bash doesn't try to expand any left-over
# dollar signs
print-%:
	@echo '$*=$(value $*) ($($*))'

assert = $(if $1,,$(error $2))

.PHONY: print-%
