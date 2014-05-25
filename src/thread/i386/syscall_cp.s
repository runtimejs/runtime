.text
.global __syscall_cp_asm
.type   __syscall_cp_asm,@function
__syscall_cp_asm:
	mov 4(%esp),%ecx
	pushl %ebx
	pushl %esi
	pushl %edi
	pushl %ebp
.global __cp_begin
__cp_begin:
	movl (%ecx),%eax
	testl %eax,%eax
	jnz __cancel
	movl 24(%esp),%eax
	movl 28(%esp),%ebx
	movl 32(%esp),%ecx
	movl 36(%esp),%edx
	movl 40(%esp),%esi
	movl 44(%esp),%edi
	movl 48(%esp),%ebp
	int $128
.global __cp_end
__cp_end:
	popl %ebp
	popl %edi
	popl %esi
	popl %ebx
	ret
