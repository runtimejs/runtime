#include <stdlib.h>

void *__memalign(size_t, size_t);

void *aligned_alloc(size_t align, size_t len)
{
	return __memalign(align, len);
}
