__asm__("\
.global _start \n\
.align  2 \n\
_start: \n\
	add r19, r0, r0 \n\
	ori r5, r1, 0 \n\
	andi r1, r1, -8 \n\
	addik r1, r1, -8 \n\
	bri __cstart \n\
	nop \n\
");
