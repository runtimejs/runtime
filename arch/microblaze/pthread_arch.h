static inline struct pthread *__pthread_self()
{
	struct pthread *self;
	__asm__ __volatile__ ("ori %0, r21, 0" : "=r" (self) );
	return self;
}

#define TP_ADJ(p) (p)

#define CANCEL_REG_IP 32
