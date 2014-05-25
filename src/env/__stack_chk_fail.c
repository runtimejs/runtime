#include <string.h>
#include <stdint.h>
#include "pthread_impl.h"

uintptr_t __stack_chk_guard;

void __init_ssp(void *entropy)
{
	if (entropy) memcpy(&__stack_chk_guard, entropy, sizeof(uintptr_t));
	else __stack_chk_guard = (uintptr_t)&__stack_chk_guard * 1103515245;

	if (libc.has_thread_pointer)
		__pthread_self()->canary = __stack_chk_guard;
}

void __stack_chk_fail(void)
{
	a_crash();
}
