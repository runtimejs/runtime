.global sigsetjmp
.global __sigsetjmp
.type sigsetjmp,@function
.type __sigsetjmp,@function
sigsetjmp:
__sigsetjmp:
	swi     r6, r5, 72
	beqi    r6, setjmp@PLT

	addi    r1, r1, -32
	swi     r15, r1, 28
	swi     r5, r1, 24
	addi    r7, r5, 76
	add     r6, r0, r0
	brlid   r15, sigprocmask@PLT
	ori     r5, r0, 2

	lwi     r15, r1, 28
	lwi     r5, r1, 24
	brid    setjmp@PLT
	addi    r1, r1, 32
