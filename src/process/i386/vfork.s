.global __vfork
.weak vfork
.type __vfork,@function
.type vfork,@function
__vfork:
vfork:
	pop %edx
	mov $190,%eax
	int $128
	push %edx
	push %eax
	call __syscall_ret
	pop %edx
	ret
