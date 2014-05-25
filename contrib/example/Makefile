ROOT=..
-include $(ROOT)/Makefile.top

EXAMPLES=example1.cpp \
         custom_allocator.cpp

OBJECTS=$(EXAMPLES:.cpp=.o)
PROGRAMS=$(EXAMPLES:.cpp=.exe)

all: $(PROGRAMS)

%.exe: %.o
	$(CC) $*.o $(LIBEASTL) -o $*.exe

%.o: %.cpp
	$(CC) $(CFLAGS) $(LDFLAGS) -c $*.cpp -o $*.o

clean:
	rm -f $(OBJECTS) $(PROGRAMS)

.phony: $(OBJECTS) $(PROGRAMS)
