__asm__("\
.text \n\
.global _start \n\
_start: \n\
	xor %ebp,%ebp \n\
	mov %esp,%eax \n\
	and $-16,%esp \n\
	push %eax \n\
	push %eax \n\
	push %eax \n\
	push %eax \n\
	call __cstart \n\
");
