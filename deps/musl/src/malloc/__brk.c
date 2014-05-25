#include <stdint.h>
#include "syscall.h"

uintptr_t __brk(uintptr_t newbrk)
{
	return __syscall(SYS_brk, newbrk);
}
