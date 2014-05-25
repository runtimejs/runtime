#include <string.h>
#include <elf.h>

#define LDSO_ARCH "i386"

#define IS_COPY(x) ((x)==R_386_COPY)
#define IS_PLT(x) ((x)==R_386_JMP_SLOT)

static inline void do_single_reloc(
	struct dso *self, unsigned char *base_addr,
	size_t *reloc_addr, int type, size_t addend,
	Sym *sym, size_t sym_size,
	struct symdef def, size_t sym_val)
{
	switch(type) {
	case R_386_32:
		*reloc_addr += sym_val;
		break;
	case R_386_PC32:
		*reloc_addr += sym_val - (size_t)reloc_addr;
		break;
	case R_386_GLOB_DAT:
	case R_386_JMP_SLOT:
		*reloc_addr = sym_val;
		break;
	case R_386_RELATIVE:
		*reloc_addr += (size_t)base_addr;
		break;
	case R_386_COPY:
		memcpy(reloc_addr, (void *)sym_val, sym_size);
		break;
	case R_386_TLS_DTPMOD32:
		*reloc_addr = def.dso ? def.dso->tls_id : self->tls_id;
		break;
	case R_386_TLS_DTPOFF32:
		*reloc_addr = def.sym->st_value;
		break;
	case R_386_TLS_TPOFF:
		*reloc_addr += def.sym
			? def.sym->st_value - def.dso->tls_offset
			: 0 - self->tls_offset;
		break;
	case R_386_TLS_TPOFF32:
		*reloc_addr += def.sym
			? def.dso->tls_offset - def.sym->st_value
			: self->tls_offset;
		break;
	}
}
