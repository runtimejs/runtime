#include <stdlib.h>
#include <stdint.h>
#include <limits.h>
#include <errno.h>
#include "libc.h"

uintptr_t __brk(uintptr_t);

#define ALIGN 16

void *__simple_malloc(size_t n)
{
	static uintptr_t cur, brk;
	uintptr_t base, new;
	static int lock[2];
	size_t align=1;

	if (!n) n++;
	if (n > SIZE_MAX/2) goto toobig;

	while (align<n && align<ALIGN)
		align += align;
	n = n + align - 1 & -align;

	LOCK(lock);
	if (!cur) cur = brk = __brk(0)+16;
	base = cur + align-1 & -align;
	if (n > SIZE_MAX - PAGE_SIZE - base) goto fail;
	if (base+n > brk) {
		new = base+n + PAGE_SIZE-1 & -PAGE_SIZE;
		if (__brk(new) != new) goto fail;
		brk = new;
	}
	cur = base+n;
	UNLOCK(lock);

	return (void *)base;

fail:
	UNLOCK(lock);
toobig:
	errno = ENOMEM;
	return 0;
}

weak_alias(__simple_malloc, malloc);
