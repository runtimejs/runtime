#include <elf.h>
#include <limits.h>
#include <sys/mman.h>
#include <string.h>
#include "pthread_impl.h"
#include "libc.h"
#include "atomic.h"
#include "syscall.h"

int __init_tp(void *p)
{
	pthread_t td = p;
	td->self = td;
	if (__set_thread_area(TP_ADJ(p)) < 0)
		return -1;
	td->tid = td->pid = __syscall(SYS_set_tid_address, &td->tid);
	td->errno_ptr = &td->errno_val;
	/* Currently, both of these predicates depend in the same thing:
	 * successful initialization of the thread pointer. However, in
	 * the future, we may support setups where setting the thread
	 * pointer is possible but threads other than the main thread
	 * cannot work, so it's best to keep the predicates separate. */
	libc.has_thread_pointer = 1;
	libc.can_do_threads = 1;
	return 0;
}

#ifndef SHARED

static long long builtin_tls[(sizeof(struct pthread) + 64)/sizeof(long long)];

struct tls_image {
	void *image;
	size_t len, size, align;
} __static_tls ATTR_LIBC_VISIBILITY;

#define T __static_tls

void *__copy_tls(unsigned char *mem)
{
	pthread_t td;
	if (!T.image) return mem;
	void **dtv = (void *)mem;
	dtv[0] = (void *)1;
#ifdef TLS_ABOVE_TP
	mem += sizeof(void *) * 2;
	mem += -((uintptr_t)mem + sizeof(struct pthread)) & (T.align-1);
	td = (pthread_t)mem;
	mem += sizeof(struct pthread);
#else
	mem += libc.tls_size - sizeof(struct pthread);
	mem -= (uintptr_t)mem & (T.align-1);
	td = (pthread_t)mem;
	mem -= T.size;
#endif
	td->dtv = dtv;
	dtv[1] = mem;
	memcpy(mem, T.image, T.len);
	return td;
}

void *__tls_get_addr(size_t *v)
{
	return (char *)__pthread_self()->dtv[1]+v[1];
}

#if ULONG_MAX == 0xffffffff
typedef Elf32_Phdr Phdr;
#else
typedef Elf64_Phdr Phdr;
#endif

void __init_tls(size_t *aux)
{
	unsigned char *p;
	size_t n;
	Phdr *phdr, *tls_phdr=0;
	size_t base = 0;
	void *mem;

	libc.tls_size = sizeof(struct pthread);

	for (p=(void *)aux[AT_PHDR],n=aux[AT_PHNUM]; n; n--,p+=aux[AT_PHENT]) {
		phdr = (void *)p;
		if (phdr->p_type == PT_PHDR)
			base = aux[AT_PHDR] - phdr->p_vaddr;
		if (phdr->p_type == PT_TLS)
			tls_phdr = phdr;
	}

	if (tls_phdr) {
		T.image = (void *)(base + tls_phdr->p_vaddr);
		T.len = tls_phdr->p_filesz;
		T.size = tls_phdr->p_memsz;
		T.align = tls_phdr->p_align;
	}

	T.size += (-T.size - (uintptr_t)T.image) & (T.align-1);
	if (T.align < 4*sizeof(size_t)) T.align = 4*sizeof(size_t);

	libc.tls_size = 2*sizeof(void *)+T.size+T.align+sizeof(struct pthread);

	if (libc.tls_size > sizeof builtin_tls) {
		mem = (void *)__syscall(
#ifdef SYS_mmap2
			SYS_mmap2,
#else
			SYS_mmap,
#endif
			0, libc.tls_size, PROT_READ|PROT_WRITE,
			MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
		/* -4095...-1 cast to void * will crash on dereference anyway,
		 * so don't bloat the init code checking for error codes and
		 * explicitly calling a_crash(). */
	} else {
		mem = builtin_tls;
	}

	/* Failure to initialize thread pointer is fatal if TLS is used. */
	if (__init_tp(__copy_tls(mem)) < 0 && tls_phdr)
		a_crash();
}
#else
void __init_tls(size_t *auxv) { }
#endif
