#include <stdlib.h>
#include <stdint.h>
#include <errno.h>
#include "libc.h"

/* This function should work with most dlmalloc-like chunk bookkeeping
 * systems, but it's only guaranteed to work with the native implementation
 * used in this library. */

void *__memalign(size_t align, size_t len)
{
	unsigned char *mem, *new, *end;
	size_t header, footer;

	if ((align & -align) != align) {
		errno = EINVAL;
		return NULL;
	}

	if (len > SIZE_MAX - align) {
		errno = ENOMEM;
		return NULL;
	}

	if (align <= 4*sizeof(size_t)) {
		if (!(mem = malloc(len)))
			return NULL;
		return mem;
	}

	if (!(mem = malloc(len + align-1)))
		return NULL;

	new = (void *)((uintptr_t)mem + align-1 & -align);
	if (new == mem) return mem;

	header = ((size_t *)mem)[-1];

	if (!(header & 7)) {
		((size_t *)new)[-2] = ((size_t *)mem)[-2] + (new-mem);
		((size_t *)new)[-1] = ((size_t *)mem)[-1] - (new-mem);
		return new;
	}

	end = mem + (header & -8);
	footer = ((size_t *)end)[-2];

	((size_t *)mem)[-1] = header&7 | new-mem;
	((size_t *)new)[-2] = footer&7 | new-mem;
	((size_t *)new)[-1] = header&7 | end-new;
	((size_t *)end)[-2] = footer&7 | end-new;

	free(mem);
	return new;
}

weak_alias(__memalign, memalign);
