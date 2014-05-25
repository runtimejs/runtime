#ifndef _INTERNAL_ATOMIC_H
#define _INTERNAL_ATOMIC_H

#include <stdint.h>

static inline int a_ctz_l(unsigned long x)
{
	static const char debruijn32[32] = {
		0, 1, 23, 2, 29, 24, 19, 3, 30, 27, 25, 11, 20, 8, 4, 13,
		31, 22, 28, 18, 26, 10, 7, 12, 21, 17, 9, 6, 16, 5, 15, 14
	};
	return debruijn32[(x&-x)*0x076be629 >> 27];
}

static inline int a_ctz_64(uint64_t x)
{
	uint32_t y = x;
	if (!y) {
		y = x>>32;
		return 32 + a_ctz_l(y);
	}
	return a_ctz_l(y);
}

int  __sh_cas(volatile int *, int, int);
int  __sh_swap(volatile int *, int);
int  __sh_fetch_add(volatile int *, int);
void __sh_store(volatile int *, int);
void __sh_and(volatile int *, int);
void __sh_or(volatile int *, int);

#define a_cas(p,t,s)     __sh_cas(p,t,s)
#define a_swap(x,v)      __sh_swap(x,v)
#define a_fetch_add(x,v) __sh_fetch_add(x, v)
#define a_store(x,v)     __sh_store(x, v)
#define a_and(x,v)       __sh_and(x, v)
#define a_or(x,v)        __sh_or(x, v)

static inline void *a_cas_p(volatile void *p, void *t, void *s)
{
	return (void *)a_cas(p, (int)t, (int)s);
}

static inline long a_cas_l(volatile void *p, long t, long s)
{
	return a_cas(p, t, s);
}

static inline void a_inc(volatile int *x)
{
	a_fetch_add(x, 1);
}

static inline void a_dec(volatile int *x)
{
	a_fetch_add(x, -1);
}

static inline void a_spin()
{
}

static inline void a_crash()
{
	*(volatile char *)0=0;
}

static inline void a_or_l(volatile void *p, long v)
{
	a_or(p, v);
}

static inline void a_and_64(volatile uint64_t *p, uint64_t v)
{
	union { uint64_t v; uint32_t r[2]; } u = { v };
	a_and((int *)p,   u.r[0]);
	a_and((int *)p+1, u.r[1]);
}

static inline void a_or_64(volatile uint64_t *p, uint64_t v)
{
	union { uint64_t v; uint32_t r[2]; } u = { v };
	a_or((int *)p,   u.r[0]);
	a_or((int *)p+1, u.r[1]);
}

#endif
