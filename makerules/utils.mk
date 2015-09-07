# General utilities.
# Make sure that gmsl is included before this file

#####################################################################
# Tuples
#
# Take two arguments and put them in the below format which is
# supposed to represent a tuple given that make has only string
# types.
makeTuple = __$1@__$2
# Extract the elements from a tuple; note that this assumes that
# they have no spaces in them (should probably eventually be fixed).
fst = $(patsubst __%,%,$(firstword $(call split,@,$1)))
snd = $(patsubst __%,%,$(lastword  $(call split,@,$1)))
# Test if the two elements in a tuple are equal.  Note that the
# string passed to this function should never be empty, even if
# both elements are because of the above representation.
_tupleElemsEq = $(call seq,$(call fst,$1),$(call snd,$1))
# Should call this one with the check
tupleElemsEq = $(call assert,$1,Empty tuple!)$(call _tupleElemsEq,$1)

#####################################################################
# Zipping
#
# zip two lists using the given function.  This is just an alias
# for the gmsl function pairmap.  Note that this function will not
# perform any truncation if the two lists are of different lengths.
zipWith = $(call pairmap,$1,$2,$3)
# zip two lists into a list of tuples
zip = $(call zipWith,makeTuple,$1,$2)
# unzip a zipped list into a list containing only the first elements
# or only the second elements, respectively.
unzipFst = $(call map,fst,$1)
unzipSnd = $(call map,snd,$1)

#####################################################################
# Some general list functions
#
# Use recursion to drop elements of a list that satisfy a predicate
# only until an element is found that does not satisfy it.
dropWhile =                             \
    $(if $2,                            \
        $(if                            \
            $(call $1,$(firstword $2)), \
            $(call dropWhile,           \
                $1,                     \
                $(call rest,$2)         \
            ),                          \
            $2                          \
        )                               \
    ,)

# This will take two lists and remove common elements from the
# beginnings of the lists, returning a list of tuples.
stripCommonPrefix = $(call dropWhile,tupleElemsEq,$(call zip,$1,$2))

#####################################################################
# Function: relPath
#
# This function takes two paths as arguments.  These paths can
# be either absolute or relative or any mix of the two.  Relative
# is always with respect to the system's current working directory.
#
# The first can be interpreted either as file or a folder but the
# second will always be interpreted as a folder (although it doesn't
# have to actually exist; see below).
#
# The function returns a relative path from the second (folder)
# to the first (file or folder).
#
# In general, this function works whether the paths exist or not.
# Note, however, that since we are calling abspath, this function
# will make use of real information about your file system if
# possible and so may return different results depending if the
# paths you specify actually exist (in which case the results it
# returns will tend to be more `optimal').
relPath =                                          \
    $(call merge,,                                 \
        $(patsubst %,../,                          \
            $(call unzipSnd,                       \
                $(call stripCommonPrefix,          \
                    $(call split,/,$(abspath $1)), \
                    $(call split,/,$(abspath $2))  \
                )                                  \
            )                                      \
        )                                          \
    )$(call merge,/,                               \
        $(call unzipFst,                           \
            $(call stripCommonPrefix,              \
                $(call split,/,$(abspath $1)),     \
                $(call split,/,$(abspath $2))      \
            )                                      \
        )                                          \
    )

#####################################################################
# Miscellaneous stuff
TURNOFF_COLORMAKE := @echo "COLORMAKE_BEGIN_RUN"
# Single quotes so that bash doesn't try to expand any left-over
# dollar signs
print-%:
	@echo '$*=$(value $*) ($($*))'

.PHONY: print-%

assertEqual = $(call assert,$(call seq,$1,$2),$3)
