#include <string.h>
#include <elf.h>
#include <endian.h>

#if __BYTE_ORDER == __LITTLE_ENDIAN
#define ENDIAN_SUFFIX "el"
#else
#define ENDIAN_SUFFIX ""
#endif

#define LDSO_ARCH "microblaze" ENDIAN_SUFFIX

#define IS_COPY(x) ((x)==R_MICROBLAZE_COPY)
#define IS_PLT(x) ((x)==R_MICROBLAZE_JUMP_SLOT)

static inline void do_single_reloc(
	struct dso *self, unsigned char *base_addr,
	size_t *reloc_addr, int type, size_t addend,
	Sym *sym, size_t sym_size,
	struct symdef def, size_t sym_val)
{
	switch(type) {
	case R_MICROBLAZE_32:
	case R_MICROBLAZE_GLOB_DAT:
	case R_MICROBLAZE_JUMP_SLOT:
		*reloc_addr = sym_val + addend;
		break;
	case R_MICROBLAZE_REL:
		*reloc_addr = (size_t)base_addr + addend;
		break;
	case R_MICROBLAZE_COPY:
		memcpy(reloc_addr, (void *)sym_val, sym_size);
		break;
	case R_MICROBLAZE_TLSDTPMOD32:
		*reloc_addr = def.dso ? def.dso->tls_id : self->tls_id;
		break;
	case R_MICROBLAZE_TLSDTPREL32:
		*reloc_addr = def.sym->st_value + addend;
		break;
	}
}

#include "syscall.h"
void __reloc_self(int c, size_t *a, size_t *dynv)
{
	char dot = '.', ex = 'x';
	char *base;
	size_t t[20], n;
	for (a+=c+1; *a; a++);
	for (a++; *a; a+=2) if (*a<20) t[*a] = a[1];
	base = (char *)t[AT_BASE];
	if (!base) base = (char *)(t[AT_PHDR] & -t[AT_PAGESZ]);
	for (a=dynv; *a; a+=2) if (*a<20) t[*a] = a[1];
	n = t[DT_RELASZ];
	for (a=(void *)(base+t[DT_RELA]); n; a+=3, n-=12)
		if (a[1]%256 == R_MICROBLAZE_REL)
			*(size_t *)(base+a[0]) = (size_t)base + a[2];
}
