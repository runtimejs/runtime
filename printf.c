/*
File: printf.c

Copyright (C) 2004  Kustaa Nyholm

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

*/

#include "printf.h"


/*
 * Configuration
 */

/* __SIZEOF_<type>__ defined at least by gcc */
#ifdef __SIZEOF_POINTER__
# define SIZEOF_POINTER __SIZEOF_POINTER__
#endif
#ifdef __SIZEOF_LONG_LONG__
# define SIZEOF_LONG_LONG __SIZEOF_LONG_LONG__
#endif
#ifdef __SIZEOF_LONG__
# define SIZEOF_LONG __SIZEOF_LONG__
#endif
#ifdef __SIZEOF_INT__
# define SIZEOF_INT __SIZEOF_INT__
#endif


/*
 * Implementation
 */
typedef void (*putcf) (void *, char, size_t);

struct param {
    char lz:1;          /**<  Leading zeros */
    char alt:1;         /**<  alternate form */
    char uc:1;          /**<  Upper case (for base16 only) */
    char align_left:1;  /**<  0 == align right (default), 1 == align left */
    unsigned int width; /**<  field width */
    char sign;          /**<  The sign to display (if any) */
    unsigned int base;  /**<  number base (e.g.: 8, 10, 16) */
    char *bf;           /**<  Buffer to output */
};


static void ulli2a(unsigned long long int num, struct param *p)
{
    int n = 0;
    unsigned long long int d = 1;
    char *bf = p->bf;
    while (num / d >= p->base)
        d *= p->base;
    while (d != 0) {
        int dgt = num / d;
        num %= d;
        d /= p->base;
        if (n || dgt > 0 || d == 0) {
            *bf++ = dgt + (dgt < 10 ? '0' : (p->uc ? 'A' : 'a') - 10);
            ++n;
        }
    }
    *bf = 0;
}

static void lli2a(long long int num, struct param *p)
{
    if (num < 0) {
        num = -num;
        p->sign = '-';
    }
    ulli2a(num, p);
}

static void uli2a(unsigned long int num, struct param *p)
{
    int n = 0;
    unsigned long int d = 1;
    char *bf = p->bf;
    while (num / d >= p->base)
        d *= p->base;
    while (d != 0) {
        int dgt = num / d;
        num %= d;
        d /= p->base;
        if (n || dgt > 0 || d == 0) {
            *bf++ = dgt + (dgt < 10 ? '0' : (p->uc ? 'A' : 'a') - 10);
            ++n;
        }
    }
    *bf = 0;
}

static void li2a(long num, struct param *p)
{
    if (num < 0) {
        num = -num;
        p->sign = '-';
    }
    uli2a(num, p);
}

static void ui2a(unsigned int num, struct param *p)
{
    int n = 0;
    unsigned int d = 1;
    char *bf = p->bf;
    while (num / d >= p->base)
        d *= p->base;
    while (d != 0) {
        int dgt = num / d;
        num %= d;
        d /= p->base;
        if (n || dgt > 0 || d == 0) {
            *bf++ = dgt + (dgt < 10 ? '0' : (p->uc ? 'A' : 'a') - 10);
            ++n;
        }
    }
    *bf = 0;
}

static void i2a(int num, struct param *p)
{
    if (num < 0) {
        num = -num;
        p->sign = '-';
    }
    ui2a(num, p);
}

static int a2d(char ch)
{
    if (ch >= '0' && ch <= '9')
        return ch - '0';
    else if (ch >= 'a' && ch <= 'f')
        return ch - 'a' + 10;
    else if (ch >= 'A' && ch <= 'F')
        return ch - 'A' + 10;
    else
        return -1;
}

static char a2u(char ch, const char **src, int base, unsigned int *nump)
{
    const char *p = *src;
    unsigned int num = 0;
    int digit;
    while ((digit = a2d(ch)) >= 0) {
        if (digit > base)
            break;
        num = num * base + digit;
        ch = *p++;
    }
    *src = p;
    *nump = num;
    return ch;
}

static int putchw(void *putp, putcf putf, struct param *p, int basecount)
{
    int count = basecount;
    char ch;
    int n = p->width;
    char *bf = p->bf;

    /* Number of filling characters */
    while (*bf++ && n > 0)
        n--;
    if (p->sign)
        n--;
    if (p->alt && p->base == 16)
        n -= 2;
    else if (p->alt && p->base == 8)
        n--;

    /* Fill with space to align to the right, before alternate or sign */
    if (!p->lz && !p->align_left) {
        while (n-- > 0) {
            putf(putp, ' ', count++);
        }
    }

    /* print sign */
    if (p->sign) {
        putf(putp, p->sign, count++);
    }

    /* Alternate */
    if (p->alt && p->base == 16) {
        putf(putp, '0', count++);
        putf(putp, (p->uc ? 'X' : 'x'), count++);
    } else if (p->alt && p->base == 8) {
        putf(putp, '0', count++);
    }

    /* Fill with zeros, after alternate or sign */
    if (p->lz) {
        while (n-- > 0) {
            putf(putp, '0', count++);
        }
    }

    /* Put actual buffer */
    bf = p->bf;
    while ((ch = *bf++)) {
        putf(putp, ch, count++);
    }

    /* Fill with space to align to the left, after string */
    if (!p->lz && p->align_left) {
        while (n-- > 0) {
            putf(putp, ' ', count++);
        }
    }

    return count;
}

int tfp_format(void *putp, putcf putf, const char *fmt, va_list va)
{
    int count = 0;

    struct param p;
    char bf[23];  /* long = 64b on some architectures */
    p.bf = bf;

    char ch;

    while ((ch = *(fmt++))) {
        if (ch != '%') {
            putf(putp, ch, count++);
        } else {
            /* Init parameter struct */
            p.lz = 0;
            p.alt = 0;
            p.width = 0;
            p.align_left = 0;
            p.sign = 0;
            char lng = 0;  /* 1 for long, 2 for long long */

            /* Flags */
            while ((ch = *(fmt++))) {
                switch (ch) {
                case '-':
                    p.align_left = 1;
                    continue;
                case '0':
                    p.lz = 1;
                    continue;
                case '#':
                    p.alt = 1;
                    continue;
                default:
                    break;
                }
                break;
            }

            /* Width */
            if (ch >= '0' && ch <= '9') {
                ch = a2u(ch, &fmt, 10, &(p.width));
            }

            /* We accept 'x.y' format but don't support it completely:
             * we ignore the 'y' digit => this ignores 0-fill
             * size and makes it == width (ie. 'x') */
            if (ch == '.') {
              p.lz = 1;  /* zero-padding */
              /* ignore actual 0-fill size: */
              do {
                ch = *(fmt++);
              } while ((ch >= '0') && (ch <= '9'));
            }

            if (ch == 'l') {
                ch = *(fmt++);
                lng = 1;
                if (ch == 'l') {
                  ch = *(fmt++);
                  lng = 2;
                }
            }
            switch (ch) {
            case 0:
                goto abort;
            case 'u':
                p.base = 10;
                if (2 == lng)
                    ulli2a(va_arg(va, unsigned long long int), &p);
                else
                  if (1 == lng)
                    uli2a(va_arg(va, unsigned long int), &p);
                else
                    ui2a(va_arg(va, unsigned int), &p);
                count = putchw(putp, putf, &p, count);
                break;
            case 'd':
            case 'i':
                p.base = 10;
                if (2 == lng)
                    lli2a(va_arg(va, long long int), &p);
                else
                  if (1 == lng)
                    li2a(va_arg(va, long int), &p);
                else
                    i2a(va_arg(va, int), &p);
                count = putchw(putp, putf, &p, count);
                break;
#ifdef SIZEOF_POINTER
            case 'p':
                p.alt = 1;
# if defined(SIZEOF_INT) && SIZEOF_POINTER <= SIZEOF_INT
                lng = 0;
# elif defined(SIZEOF_LONG) && SIZEOF_POINTER <= SIZEOF_LONG
                lng = 1;
# elif defined(SIZEOF_LONG_LONG) && SIZEOF_POINTER <= SIZEOF_LONG_LONG
                lng = 2;
# endif
#endif
            case 'x':
            case 'X':
                p.base = 16;
                p.uc = (ch == 'X')?1:0;
                if (2 == lng)
                    ulli2a(va_arg(va, unsigned long long int), &p);
                else
                  if (1 == lng)
                    uli2a(va_arg(va, unsigned long int), &p);
                else
                    ui2a(va_arg(va, unsigned int), &p);
                count = putchw(putp, putf, &p, count);
                break;
            case 'o':
                p.base = 8;
                ui2a(va_arg(va, unsigned int), &p);
                count = putchw(putp, putf, &p, count);
                break;
            case 'c':
                putf(putp, (char)(va_arg(va, int)), count++);
                break;
            case 's':
                p.bf = va_arg(va, char *);
                count = putchw(putp, putf, &p, count);
                p.bf = bf;
                break;
            case '%':
                putf(putp, ch, count++);
            default:
                break;
            }
        }
    }
 abort: return count;
}

struct cp_opt {
    char* buf;
    size_t max_len;
    bool max_len_enabled;
};

static void putcp(void* optp, char c, size_t offset) {
    cp_opt* opt = reinterpret_cast<cp_opt*>(optp);
    size_t max_len = opt->max_len;

    bool max_len_enabled = opt->max_len_enabled;

    if (max_len_enabled && max_len == 0) return;
    if (!max_len_enabled || offset < max_len - 1) {
        *(opt->buf)++ = c;
    }
}

int tfp_sprintf(char* s, const char* fmt, ...) {
    va_list va;
    va_start(va, fmt);
    int count = tfp_vsprintf(s, fmt, va);
    va_end(va);
    return count;
}

int tfp_snprintf(char* s, size_t n, const char* fmt, ...) {
    va_list va;
    va_start(va, fmt);
    int count = tfp_vsnprintf(s, n, fmt, va);
    va_end(va);
    return count;
}

int tfp_vsprintf(char* s, const char* fmt, va_list va) {
    cp_opt opt;
    opt.buf = s;
    opt.max_len = 0;
    opt.max_len_enabled = false;
    void* optp = reinterpret_cast<void*>(&opt);
    int count = tfp_format(optp, putcp, fmt, va);
    putcp(optp, 0, 0);
    return count;
}

int tfp_vsnprintf(char* s, size_t n, const char* fmt, va_list va) {
    cp_opt opt;
    opt.buf = s;
    opt.max_len = n;
    opt.max_len_enabled = true;
    void* optp = reinterpret_cast<void*>(&opt);
    int count = tfp_format(optp, putcp, fmt, va);
    if (n > 0) {
        opt.max_len_enabled = false;
        putcp(optp, 0, 0);
    }
    return count;
}
