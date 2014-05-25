.text
.global __set_thread_area
.type   __set_thread_area,@function
__set_thread_area:
	push %ebx
	push $0x51
	push $0xfffff
	push 16(%esp)
	push $-1
	mov %esp,%ebx
	xor %eax,%eax
	mov $243,%al
	int $128
	testl %eax,%eax
	jnz 1f
	movl (%esp),%ecx
	leal 3(,%ecx,8),%ecx
	movw %cx,%gs
1:
	addl $16,%esp
	popl %ebx
	ret
