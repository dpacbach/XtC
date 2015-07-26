NEW_C_SRCS := src/libsrc/src/strextra.c \
              src/libsrc/src/xtc.c
NEW_DEPS   := $(NEW_C_SRCS:.c=.d)

C_SRCS    := $(C_SRCS) $(NEW_C_SRCS)
OBJS      := $(OBJS) $(NEW_C_SRCS:.c=.o)
DEPS      := $(DEPS) $(NEW_DEPS)
BINARIES  := $(BINARIES) $(LIB_NAME)
LIBRARIES := $(LIBRARIES) $(LIB_NAME)

-include $(NEW_DEPS)

src/libsrc/src/%.o: src/libsrc/src/%.c
	$(CC) -I$(LIB_INTERFACE) -Isrc/libsrc/src -I$(LIBXML2_INCLUDE) $(CFLAGS_LIB) $(CFLAGS) -c $< -o $@

$(LIB_NAME): src/libsrc/src/xtc.o src/libsrc/src/strextra.o
	$(LD) $(LDFLAGS_LIB) $(LDFLAGS) $(LIBXML2_LIB) $^ -o $@
