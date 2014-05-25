#include "pthread_impl.h"

int pthread_setcancelstate(int new, int *old)
{
	if (new > 1U) return EINVAL;
	if (!libc.has_thread_pointer) return ENOSYS;
	struct pthread *self = __pthread_self();
	if (old) *old = self->canceldisable;
	self->canceldisable = new;
	return 0;
}
