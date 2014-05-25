ROOT=.
-include $(ROOT)/Makefile.top

EASTL_SRC_DIR=$(ROOT)/src
EASTL_SOURCES=$(EASTL_SRC_DIR)/allocator.cpp \
    $(EASTL_SRC_DIR)/assert.cpp \
    $(EASTL_SRC_DIR)/fixed_pool.cpp \
    $(EASTL_SRC_DIR)/hashtable.cpp \
    $(EASTL_SRC_DIR)/red_black_tree.cpp \
    $(EASTL_SRC_DIR)/string.cpp

EASTL_OBJECTS=$(EASTL_SOURCES:.cpp=.o)

all: $(EASTL_OBJECTS)
	ar rcs $(LIBEASTL) $(EASTL_OBJECTS)

%.o: %.cpp
	$(CC) $(CFLAGS) -c $*.cpp -o $*.o

clean:
	rm -f $(EASTL_OBJECTS) $(LIBEASTL)
