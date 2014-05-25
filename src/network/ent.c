#include "libc.h"

void sethostent(int x)
{
}

void *gethostent()
{
	return 0;
}

void endhostent(void)
{
}

weak_alias(sethostent, setnetent);
weak_alias(gethostent, getnetent);
weak_alias(endhostent, endnetent);

weak_alias(sethostent, setservent);
weak_alias(gethostent, getservent);
weak_alias(endhostent, endservent);

weak_alias(sethostent, setprotoent);
weak_alias(gethostent, getprotoent);
weak_alias(endhostent, endprotoent);
