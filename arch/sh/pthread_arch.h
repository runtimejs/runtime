static inline struct pthread *__pthread_self()
{
	char *self;
	__asm__ __volatile__ ("stc gbr,%0" : "=r" (self) );
	return (struct pthread *) (self + 8 - sizeof(struct pthread));
}

#define TLS_ABOVE_TP
#define TP_ADJ(p) ((char *)(p) + sizeof(struct pthread) - 8)

#define CANCEL_REG_IP 17
