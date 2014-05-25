#include "libc.h"

#define LLSC_CLOBBERS   "r0", "t", "memory"
#define LLSC_START(mem)            \
	"0:	movli.l @" mem ", r0\n"
#define LLSC_END(mem)              \
	"1:	movco.l r0, @" mem "\n"    \
	"	bf 0b\n"                   \
	"	synco\n"

/* gusa is a hack in the kernel which lets you create a sequence of instructions
 * which will be restarted if the process is preempted in the middle of the
 * sequence. It will do for implementing atomics on non-smp systems. ABI is:
 * r0  = address of first instruction after the atomic sequence
 * r1  = original stack pointer
 * r15 = -1 * length of atomic sequence in bytes
 */
#define GUSA_CLOBBERS   "r0", "r1", "memory"
#define GUSA_START(mem,old,nop)    \
	"	.align 2\n"                \
	"	mova 1f, r0\n"             \
	nop                            \
	"	mov r15, r1\n"             \
	"	mov #(0f-1f), r15\n"       \
	"0:	mov.l @" mem ", " old "\n"
/* the target of mova must be 4 byte aligned, so we may need a nop */
#define GUSA_START_ODD(mem,old)  GUSA_START(mem,old,"")
#define GUSA_START_EVEN(mem,old) GUSA_START(mem,old,"\tnop\n")
#define GUSA_END(mem,new)          \
	"	mov.l " new ", @" mem "\n" \
	"1:	mov r1, r15\n"

#define CPU_HAS_LLSC 0x0040

int __sh_cas(volatile int *p, int t, int s)
{
	int old;
	if (__hwcap & CPU_HAS_LLSC) {
		__asm__ __volatile__(
			LLSC_START("%1")
			"	mov r0, %0\n"
			"	cmp/eq %0, %2\n"
			"	bf 1f\n"
			"	mov %3, r0\n"
			LLSC_END("%1")
			: "=&r"(old) : "r"(p), "r"(t), "r"(s) : LLSC_CLOBBERS);
	} else {
		__asm__ __volatile__(
			GUSA_START_EVEN("%1", "%0")
			"	cmp/eq %0, %2\n"
			"	bf 1f\n"
			GUSA_END("%1", "%3")
			: "=&r"(old) : "r"(p), "r"(t), "r"(s) : GUSA_CLOBBERS, "t");
	}
	return old;
}

int __sh_swap(volatile int *x, int v)
{
	int old;
	if (__hwcap & CPU_HAS_LLSC) {
		__asm__ __volatile__(
			LLSC_START("%1")
			"	mov r0, %0\n"
			"	mov %2, r0\n"
			LLSC_END("%1")
			: "=&r"(old) : "r"(x), "r"(v) : LLSC_CLOBBERS);
	} else {
		__asm__ __volatile__(
			GUSA_START_EVEN("%1", "%0")
			GUSA_END("%1", "%2")
			: "=&r"(old) : "r"(x), "r"(v) : GUSA_CLOBBERS);
	}
	return old;
}

int __sh_fetch_add(volatile int *x, int v)
{
	int old, dummy;
	if (__hwcap & CPU_HAS_LLSC) {
		__asm__ __volatile__(
			LLSC_START("%1")
			"	mov r0, %0\n"
			"	add %2, r0\n"
			LLSC_END("%1")
			: "=&r"(old) : "r"(x), "r"(v) : LLSC_CLOBBERS);
	} else {
		__asm__ __volatile__(
			GUSA_START_EVEN("%2", "%0")
			"	mov %0, %1\n"
			"	add %3, %1\n"
			GUSA_END("%2", "%1")
			: "=&r"(old), "=&r"(dummy) : "r"(x), "r"(v) : GUSA_CLOBBERS);
	}
	return old;
}

void __sh_store(volatile int *p, int x)
{
	if (__hwcap & CPU_HAS_LLSC) {
		__asm__ __volatile__(
			"	mov.l %1, @%0\n"
			"	synco\n"
			: : "r"(p), "r"(x) : "memory");
	} else {
		__asm__ __volatile__(
			"	mov.l %1, @%0\n"
			: : "r"(p), "r"(x) : "memory");
	}
}

void __sh_and(volatile int *x, int v)
{
	int dummy;
	if (__hwcap & CPU_HAS_LLSC) {
		__asm__ __volatile__(
			LLSC_START("%0")
			"	and %1, r0\n"
			LLSC_END("%0")
			: : "r"(x), "r"(v) : LLSC_CLOBBERS);
	} else {
		__asm__ __volatile__(
			GUSA_START_ODD("%1", "%0")
			"	and %2, %0\n"
			GUSA_END("%1", "%0")
			: "=&r"(dummy) : "r"(x), "r"(v) : GUSA_CLOBBERS);
	}
}

void __sh_or(volatile int *x, int v)
{
	int dummy;
	if (__hwcap & CPU_HAS_LLSC) {
		__asm__ __volatile__(
			LLSC_START("%0")
			"	or %1, r0\n"
			LLSC_END("%0")
			: : "r"(x), "r"(v) : LLSC_CLOBBERS);
	} else {
		__asm__ __volatile__(
			GUSA_START_ODD("%1", "%0")
			"	or %2, %0\n"
			GUSA_END("%1", "%0")
			: "=&r"(dummy) : "r"(x), "r"(v) : GUSA_CLOBBERS);
	}
}
