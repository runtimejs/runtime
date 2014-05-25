#if __BYTE_ORDER == __BIG_ENDIAN
#define ENDIAN_SUFFIX "eb"
#else
#define ENDIAN_SUFFIX ""
#endif

#define LDSO_ARCH "sh" ENDIAN_SUFFIX

#define IS_COPY(x) ((x) == R_SH_COPY)
#define IS_PLT(x)  ((x) == R_SH_JMP_SLOT)

static inline void do_single_reloc(
	struct dso *self, unsigned char *base_addr,
	size_t *reloc_addr, int type, size_t addend,
	Sym *sym, size_t sym_size,
	struct symdef def, size_t sym_val)
{
	switch(type) {
	case R_SH_GLOB_DAT:
	case R_SH_JMP_SLOT:
		*reloc_addr = sym_val;
		break;
	case R_SH_RELATIVE:
		*reloc_addr = (size_t)base_addr + addend;
		break;
	case R_SH_DIR32:
		*reloc_addr = sym_val + addend;
		break;
	case R_SH_REL32:
		*reloc_addr = sym_val + addend - (size_t)reloc_addr + (size_t)base_addr;
		break;
	case R_SH_COPY:
		memcpy(reloc_addr, (void *)sym_val, sym_size);
		break;
	case R_SH_TLS_DTPMOD32:
		*reloc_addr += def.dso ? def.dso->tls_id : self->tls_id;
		break;
	case R_SH_TLS_DTPOFF32:
		*reloc_addr += def.sym->st_value;
		break;
	case R_SH_TLS_TPOFF32:
		*reloc_addr += def.sym
			? def.sym->st_value + def.dso->tls_offset + 8
			: self->tls_offset + 8;
		break;
	}
}
