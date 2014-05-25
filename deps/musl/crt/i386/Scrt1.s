.weak _init
.weak _fini
.text
.global _start
_start:
	xor %ebp,%ebp
	pop %ecx
	mov %esp,%eax
	and $-16,%esp
	push %esp
	push %esp
	push %edx
	call 1f
1:	addl $_GLOBAL_OFFSET_TABLE_,(%esp)
	pop %ebx
	call 1f
1:	addl $[_fini-.],(%esp)
	call 1f
1:	addl $[_init-.],(%esp)
	push %eax
	push %ecx
	push main@GOT(%ebx)
	call __libc_start_main@plt
1:	jmp 1b
