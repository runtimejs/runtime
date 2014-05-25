static inline struct pthread *__pthread_self()
{
#ifdef __clang__
	char *tp;
	__asm__ __volatile__ ("mr %0, 2" : "=r"(tp) : : );
#else
	register char *tp __asm__("r2");
#endif
	return (pthread_t)(tp - 0x7000 - sizeof(struct pthread));
}
                        
#define TLS_ABOVE_TP
#define TP_ADJ(p) ((char *)(p) + sizeof(struct pthread) + 0x7000)

// offset of the PC register in mcontext_t, divided by the system wordsize
// the kernel calls the ip "nip", it's the first saved value after the 32
// GPRs.
#define CANCEL_REG_IP 32

