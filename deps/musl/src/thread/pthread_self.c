#include "pthread_impl.h"

pthread_t pthread_self()
{
	return __pthread_self();
}
