#include <stdlib.h>
#include <errno.h>

void *__memalign(size_t, size_t);

int posix_memalign(void **res, size_t align, size_t len)
{
	if (align < sizeof(void *)) return EINVAL;
	void *mem = __memalign(align, len);
	if (!mem) return errno;
	*res = mem;
	return 0;
}
