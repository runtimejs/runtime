#include <sys/resource.h>
#include <errno.h>
#include "syscall.h"
#include "libc.h"

int getrlimit(int resource, struct rlimit *rlim)
{
	unsigned long k_rlim[2];
	int ret = syscall(SYS_prlimit64, 0, resource, 0, rlim);
	if (!ret || errno != ENOSYS)
		return ret;
	if (syscall(SYS_getrlimit, resource, k_rlim) < 0)
		return -1;
	rlim->rlim_cur = k_rlim[0] == -1UL ? RLIM_INFINITY : k_rlim[0];
	rlim->rlim_max = k_rlim[1] == -1UL ? RLIM_INFINITY : k_rlim[1];
	return 0;
}

LFS64(getrlimit);
