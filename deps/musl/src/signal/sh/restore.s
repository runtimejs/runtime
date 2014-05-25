.global __restore
.type   __restore, @function
__restore:
	mov   #119, r3  !__NR_sigreturn
	trapa #16

	or    r0, r0
	or    r0, r0
	or    r0, r0
	or    r0, r0
	or    r0, r0

.global __restore_rt
.type   __restore_rt, @function
__restore_rt:
	mov   #100, r3  !__NR_rt_sigreturn
	add   #73, r3
	trapa #16

	or    r0, r0
	or    r0, r0
	or    r0, r0
	or    r0, r0
	or    r0, r0
