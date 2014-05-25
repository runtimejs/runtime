#include <fcntl.h>
#include <stdarg.h>
#include "syscall.h"
#include "libc.h"

int open(const char *filename, int flags, ...)
{
	mode_t mode;
	va_list ap;
	va_start(ap, flags);
	mode = va_arg(ap, mode_t);
	va_end(ap);
	return sys_open_cp(filename, flags, mode);
}

LFS64(open);
