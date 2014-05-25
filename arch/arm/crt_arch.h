__asm__("\
.global _start \n\
.type _start,%function \n\
_start: \n\
	mov fp, #0 \n\
	mov lr, #0 \n\
	mov a1, sp \n\
	and sp, sp, #-16 \n\
	bl __cstart \n\
");
