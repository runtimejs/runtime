#define _GNU_SOURCE
#include <sched.h>
#include "pthread_impl.h"
#include "syscall.h"

int sched_setaffinity(pid_t tid, size_t size, const cpu_set_t *set)
{
	return syscall(SYS_sched_setaffinity, tid, size, set);
}

int pthread_setaffinity_np(pthread_t td, size_t size, const cpu_set_t *set)
{
	return syscall(SYS_sched_setaffinity, td->tid, size, set);
}

int sched_getaffinity(pid_t tid, size_t size, cpu_set_t *set)
{
	long ret = __syscall(SYS_sched_getaffinity, tid, size, set);
	if (ret > 0) ret = 0;
	return __syscall_ret(ret);
}

int pthread_getaffinity_np(pthread_t td, size_t size, cpu_set_t *set)
{
	return sched_getaffinity(td->tid, size, set);
}
