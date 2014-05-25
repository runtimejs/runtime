.global __vfork
.weak vfork
.type __vfork,@function
.type vfork,@function
__vfork:
vfork:
	pop %rdx
	mov $0x4000003a,%eax /* SYS_vfork */
	syscall
	push %rdx
	mov %rax,%rdi
	jmp __syscall_ret
