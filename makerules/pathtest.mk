# Make sure that gmsl is included before this file

toPair = __$1@__$2

fst = $(patsubst __%,%,$(firstword $(call split,@,$1)))
snd = $(patsubst __%,%,$(lastword  $(call split,@,$1)))
# put an assert here to make sure tuple is non empty?
pairEq = $(call seq,$(call fst,$1),$(call snd,$1))

zipWith = $(call pairmap,$1,$2,$3)
zip = $(call zipWith,toPair,$1,$2)

unzipFst = $(call map,fst,$1)
unzipSnd = $(call map,snd,$1)

dropWhile  = $(if $2,$(call dropWhileR,$1,$2),)
dropWhileR = $(if $(call $1,$(firstword $2)),$(call dropWhile,$1,$(call rest,$2)),$2)

stripCommonPrefix = $(call dropWhile,pairEq,$(call zip,$1,$2))

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
################################################################

#$(info test1=$(call relPath,       \
#    a,                             \
#    .                              \
#))
#$(info test2=$(call relPath,       \
#    ./a,                           \
#    .                              \
#))
#$(info test3=$(call relPath,       \
#    ../a,                          \
#    ../                            \
#))
#$(info test4=$(call relPath,       \
#    ../a,                          \
#    .                              \
#))
#$(info test5=$(call relPath,       \
#    a,                             \
#    ../                            \
#))
#$(info test6=$(call relPath,       \
#    a,                             \
#    ../../../                      \
#))
#$(info test7=$(call relPath,       \
#    ../../../../a,                 \
#    .                              \
#))
#$(info test8=$(call relPath,       \
#    ../../../../a,                 \
#    ../../../../                   \
#))
#$(info test9=$(call relPath,       \
#    ../../../../a,                 \
#    ../../                         \
#))
#$(info test10=$(call relPath,      \
#    ../../xtc/src/exesrc/makefile, \
#    ../src/testsrc/hello           \
#))
#$(info test11=$(call relPath,      \
#    ../../xtc/b/c/d,               \
#    ../b/c                         \
#))
