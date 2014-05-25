#define _GNU_SOURCE
#include <sys/resource.h>
#include "syscall.h"
#include "libc.h"

int prlimit(pid_t pid, int resource, const struct rlimit *new_limit, struct rlimit *old_limit)
{
	return syscall(SYS_prlimit64, pid, resource, new_limit, old_limit);
}

#undef prlimit64
LFS64(prlimit);
