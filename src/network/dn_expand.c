#include <resolv.h>
#include "libc.h"

int __dn_expand(const unsigned char *base, const unsigned char *end, const unsigned char *src, char *dest, int space)
{
	const unsigned char *p = src;
	int len = -1, j;
	if (space > 256) space = 256;
	if (p==end || !*p) return -1;
	for (;;) {
		if (*p & 0xc0) {
			if (p+1==end) return -1;
			j = ((p[0] & 0x3f) << 8) | p[1];
			if (len < 0) len = p+2-src;
			if (j >= end-base) return -1;
			p = base+j;
		} else if (*p) {
			j = *p+1;
			if (j>=end-p || j>space) return -1;
			while (--j) *dest++ = *++p;
			*dest++ = *++p ? '.' : 0;
		} else {
			if (len < 0) len = p+1-src;
			return len;
		}
	}
}

weak_alias(__dn_expand, dn_expand);
