__asm__("\
.global _start \n\
_start: \n\
	mov r15, r4 \n\
	mov #-16, r0 \n\
	and r0, r15 \n\
	bsr __cstart \n\
	nop \n\
");

/* used by gcc for switching the FPU between single and double precision */
const unsigned long __fpscr_values[2] = { 0, 0x80000 };
