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

#if ((__ARM_ARCH_6__ || __ARM_ARCH_6K__ || __ARM_ARCH_6ZK__) && !__thumb__) \
 || __ARM_ARCH_7A__ || __ARM_ARCH_7R__ || __ARM_ARCH >= 7

#if __ARM_ARCH_7A__ || __ARM_ARCH_7R__ ||  __ARM_ARCH >= 7
#define MEM_BARRIER "dmb ish"
#else
#define MEM_BARRIER "mcr p15,0,r0,c7,c10,5"
#endif

static inline int __k_cas(int t, int s, volatile int *p)
{
	int ret;
	__asm__(
		"	" MEM_BARRIER "\n"
		"1:	ldrex %0,%3\n"
		"	subs %0,%0,%1\n"
#ifdef __thumb__
		"	itt eq\n"
#endif
		"	strexeq %0,%2,%3\n"
		"	teqeq %0,#1\n"
		"	beq 1b\n"
		"	" MEM_BARRIER "\n"
		: "=&r"(ret)
		: "r"(t), "r"(s), "Q"(*p)
		: "memory", "cc" );
	return ret;
}
#else
#define __k_cas ((int (*)(int, int, volatile int *))0xffff0fc0)
#endif

static inline int a_cas(volatile int *p, int t, int s)
{
	int old;
	for (;;) {
		if (!__k_cas(t, s, p))
			return t;
		if ((old=*p) != t)
			return old;
	}
}

static inline void *a_cas_p(volatile void *p, void *t, void *s)
{
	return (void *)a_cas(p, (int)t, (int)s);
}

static inline long a_cas_l(volatile void *p, long t, long s)
{
	return a_cas(p, t, s);
}

static inline int a_swap(volatile int *x, int v)
{
	int old;
	do old = *x;
	while (__k_cas(old, v, x));
	return old;
}

static inline int a_fetch_add(volatile int *x, int v)
{
	int old;
	do old = *x;
	while (__k_cas(old, old+v, x));
	return old;
}

static inline void a_inc(volatile int *x)
{
	a_fetch_add(x, 1);
}

static inline void a_dec(volatile int *x)
{
	a_fetch_add(x, -1);
}

static inline void a_store(volatile int *p, int x)
{
	while (__k_cas(*p, x, p));
}

static inline void a_spin()
{
}

static inline void a_crash()
{
	*(volatile char *)0=0;
}

static inline void a_and(volatile int *p, int v)
{
	int old;
	do old = *p;
	while (__k_cas(old, old&v, p));
}

static inline void a_or(volatile int *p, int v)
{
	int old;
	do old = *p;
	while (__k_cas(old, old|v, p));
}

static inline void a_or_l(volatile void *p, long v)
{
	a_or(p, v);
}

static inline void a_and_64(volatile uint64_t *p, uint64_t v)
{
	union { uint64_t v; uint32_t r[2]; } u = { v };
	a_and((int *)p, u.r[0]);
	a_and((int *)p+1, u.r[1]);
}

static inline void a_or_64(volatile uint64_t *p, uint64_t v)
{
	union { uint64_t v; uint32_t r[2]; } u = { v };
	a_or((int *)p, u.r[0]);
	a_or((int *)p+1, u.r[1]);
}

#endif
