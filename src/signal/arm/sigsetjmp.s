.global sigsetjmp
.global __sigsetjmp
.type sigsetjmp,%function
.type __sigsetjmp,%function
sigsetjmp:
__sigsetjmp:
	str a2,[a1,#256]
	tst a2,a2
	beq setjmp
	push {a1,lr}
	add a3,a1,#260
	mov a2,#0
	mov a1,#2
	bl sigprocmask
	pop {a1,lr}
	b setjmp
