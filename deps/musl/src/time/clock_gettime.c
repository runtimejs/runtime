#include <time.h>
#include <errno.h>
#include <stdint.h>
#include "syscall.h"
#include "libc.h"
#include "atomic.h"

static int sc_clock_gettime(clockid_t clk, struct timespec *ts)
{
	int r = __syscall(SYS_clock_gettime, clk, ts);
	if (!r) return r;
	if (r == -ENOSYS) {
		if (clk == CLOCK_REALTIME) {
			__syscall(SYS_gettimeofday, ts, 0);
			ts->tv_nsec = (int)ts->tv_nsec * 1000;
			return 0;
		}
		r = -EINVAL;
	}
	errno = -r;
	return -1;
}

void *__vdsosym(const char *, const char *);

int __clock_gettime(clockid_t clk, struct timespec *ts)
{
#ifdef VDSO_CGT_SYM
	static int (*cgt)(clockid_t, struct timespec *);
	if (!cgt) {
		void *f = __vdsosym(VDSO_CGT_VER, VDSO_CGT_SYM);
		if (!f) f = (void *)sc_clock_gettime;
		a_cas_p(&cgt, 0, f);
	}
	return cgt(clk, ts);
#else
	return sc_clock_gettime(clk, ts);
#endif
}

weak_alias(__clock_gettime, clock_gettime);
