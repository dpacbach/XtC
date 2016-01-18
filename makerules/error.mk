#####################################################################
# Error handling functions

assert_equal = $(call assert,$(call seq,$1,$2),$3)

#####################################################################
## No longer used
## This is the error given to the user if make attempts to use a rule
## in a makefile in one folder to build a target in another folder
## which indicates that the wrong rule was selected.  This can happen
## as a result of make's process for deciding which rule to use for
## a given target when there are multiple possible matches, coupled
## with the dependency structure of the program, the order in which
## make files are read in, and make's attempt to build prerequisites
## of targets which may reside in other folders (it has a global view
## of all dependencies).
#location_error = $(warning error: $@ cannot by built by a rule in \
    #the "$(call yesDot,$1)" folder!)@false
## Check for and report the location_error described above
#assert_target_location = $(call $(call ifseq,$(call normalizeSlashes,$1),$(target_path),,location_error),$1)



# Check to make sure all of the locations have been defined.
#location_error = $(error "LOCATION_$1 not defined")
#is_undefined   = $(call seq,$(origin LOCATION_$1),undefined)
#assert_loc     = $(if $(call is_undefined,$1),$(call location_error,$1),)

#$(call map,assert_loc,$(ALL_LOCATIONS))
