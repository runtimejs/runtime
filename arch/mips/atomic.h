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

static inline int a_cas(volatile int *p, int t, int s)
{
	int dummy;
	__asm__ __volatile__(
		".set push\n"
		".set mips2\n"
		".set noreorder\n"
		"1:	ll %0, 0(%2)\n"
		"	bne %0, %3, 1f\n"
		"	addu %1, %4, $0\n"
		"	sc %1, 0(%2)\n"
		"	beq %1, $0, 1b\n"
		"	nop\n"
		"1:	\n"
		".set pop\n"
		: "=&r"(t), "=&r"(dummy) : "r"(p), "r"(t), "r"(s) : "memory" );
        return t;
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
	int old, dummy;
	__asm__ __volatile__(
		".set push\n"
		".set mips2\n"
		".set noreorder\n"
		"1:	ll %0, 0(%2)\n"
		"	addu %1, %3, $0\n"
		"	sc %1, 0(%2)\n"
		"	beq %1, $0, 1b\n"
		"	nop\n"
		"1:	\n"
		".set pop\n"
		: "=&r"(old), "=&r"(dummy) : "r"(x), "r"(v) : "memory" );
        return old;
}

static inline int a_fetch_add(volatile int *x, int v)
{
	int old, dummy;
	__asm__ __volatile__(
		".set push\n"
		".set mips2\n"
		".set noreorder\n"
		"1:	ll %0, 0(%2)\n"
		"	addu %1, %0, %3\n"
		"	sc %1, 0(%2)\n"
		"	beq %1, $0, 1b\n"
		"	nop\n"
		"1:	\n"
		".set pop\n"
		: "=&r"(old), "=&r"(dummy) : "r"(x), "r"(v) : "memory" );
        return old;
}

static inline void a_inc(volatile int *x)
{
	int dummy;
	__asm__ __volatile__(
		".set push\n"
		".set mips2\n"
		".set noreorder\n"
		"1:	ll %0, 0(%1)\n"
		"	addu %0, %0, 1\n"
		"	sc %0, 0(%1)\n"
		"	beq %0, $0, 1b\n"
		"	nop\n"
		"1:	\n"
		".set pop\n"
		: "=&r"(dummy) : "r"(x) : "memory" );
}

static inline void a_dec(volatile int *x)
{
	int dummy;
	__asm__ __volatile__(
		".set push\n"
		".set mips2\n"
		".set noreorder\n"
		"1:	ll %0, 0(%1)\n"
		"	subu %0, %0, 1\n"
		"	sc %0, 0(%1)\n"
		"	beq %0, $0, 1b\n"
		"	nop\n"
		"1:	\n"
		".set pop\n"
		: "=&r"(dummy) : "r"(x) : "memory" );
}

static inline void a_store(volatile int *p, int x)
{
	int dummy;
	__asm__ __volatile__(
		".set push\n"
		".set mips2\n"
		".set noreorder\n"
		"1:	ll %0, 0(%1)\n"
		"	addu %0, %2, $0\n"
		"	sc %0, 0(%1)\n"
		"	beq %0, $0, 1b\n"
		"	nop\n"
		"1:	\n"
		".set pop\n"
		: "=&r"(dummy) : "r"(p), "r"(x) : "memory" );
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
	int dummy;
	__asm__ __volatile__(
		".set push\n"
		".set mips2\n"
		".set noreorder\n"
		"1:	ll %0, 0(%1)\n"
		"	and %0, %0, %2\n"
		"	sc %0, 0(%1)\n"
		"	beq %0, $0, 1b\n"
		"	nop\n"
		"1:	\n"
		".set pop\n"
		: "=&r"(dummy) : "r"(p), "r"(v) : "memory" );
}

static inline void a_or(volatile int *p, int v)
{
	int dummy;
	__asm__ __volatile__(
		".set push\n"
		".set mips2\n"
		".set noreorder\n"
		"1:	ll %0, 0(%1)\n"
		"	or %0, %0, %2\n"
		"	sc %0, 0(%1)\n"
		"	beq %0, $0, 1b\n"
		"	nop\n"
		"1:	\n"
		".set pop\n"
		: "=&r"(dummy) : "r"(p), "r"(v) : "memory" );
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
