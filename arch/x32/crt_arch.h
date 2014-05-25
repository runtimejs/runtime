__asm__("\
.text \n\
.global _start \n\
_start: \n\
	xor %rbp,%rbp \n\
	mov %rsp,%rdi \n\
	andq $-16,%rsp \n\
	call __cstart \n\
");
