.global __restore_rt
.global __restore
.type __restore_rt,@function
.type __restore,@function
__restore_rt:
__restore:
	movl $15, %eax
	syscall
