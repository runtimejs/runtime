
CPPFLAGS+=-I.
CFLAGS+=-Wall -W -Wextra -O3 -g
# RUNNER:=valgrind

all: printf_test

tests: printf_test
	$(RUNNER) ./printf_test

printf_test: printf_test.o printf.o
	$(CC) -o $@ $^

clean:
	$(RM) printf_test *~ *.o
