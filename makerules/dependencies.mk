map = $(foreach i,$2,$(call $1,$(i)))

#ALL_MODULES :=

#INCLUDE_CMD     = $(MODULE_CMD)
#INCLUDE_TEST    = $(MODULE_TEST)
#INCLUDE_LIB     = $(MODULE_LIB)
#INCLUDE_LIB_INT = $(MODULE_LIB)/interface

#MODULE_CMD_DEPS  = $(INCLUDE_CMD)  $(INCLUDE_LIB_INT)
#MODULE_TEST_DEPS = $(INCLUDE_TEST) $(INCLUDE_LIB_INT)
#MODULE_LIB_DEPS  = $(INCLUDE_LIB)  $(INCLUDE_LIB_INT)

ONE := one_eval
TWO := two_eval
THREE := three_eval

attach_I = -I$1

ARRAY   = $(ONE) $(TWO) $(THREE)
ARRAY_I = $(call map,attach_I,$(ARRAY))

$(info ARRAY=$(ARRAY))
$(info ARRAY_I=$(ARRAY_I))
