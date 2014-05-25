#include <string.h>
#include <elf.h>
#include <endian.h>

#if __BYTE_ORDER == __BIG_ENDIAN
#define ENDIAN_SUFFIX "eb"
#else
#define ENDIAN_SUFFIX ""
#endif

#if __SOFTFP__
#define FP_SUFFIX ""
#else
#define FP_SUFFIX "hf"
#endif

#define LDSO_ARCH "arm" ENDIAN_SUFFIX FP_SUFFIX

#define IS_COPY(x) ((x)==R_ARM_COPY)
#define IS_PLT(x) ((x)==R_ARM_JUMP_SLOT)

static inline void do_single_reloc(
	struct dso *self, unsigned char *base_addr,
	size_t *reloc_addr, int type, size_t addend,
	Sym *sym, size_t sym_size,
	struct symdef def, size_t sym_val)
{
	switch(type) {
	case R_ARM_ABS32:
		*reloc_addr += sym_val;
		break;
	case R_ARM_GLOB_DAT:
	case R_ARM_JUMP_SLOT:
		*reloc_addr = sym_val;
		break;
	case R_ARM_RELATIVE:
		*reloc_addr += (size_t)base_addr;
		break;
	case R_ARM_COPY:
		memcpy(reloc_addr, (void *)sym_val, sym_size);
		break;
	case R_ARM_TLS_DTPMOD32:
		*reloc_addr = def.dso ? def.dso->tls_id : self->tls_id;
		break;
	case R_ARM_TLS_DTPOFF32:
		*reloc_addr += def.sym->st_value;
		break;
	case R_ARM_TLS_TPOFF32:
		*reloc_addr += def.sym
			? def.sym->st_value + def.dso->tls_offset + 8
			: self->tls_offset + 8;
		break;
	}
}

#define NO_LEGACY_INITFINI
