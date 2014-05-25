.section .init
	pop {r0,lr}
	tst lr,#1
	moveq pc,lr
	bx lr

.section .fini
	pop {r0,lr}
	tst lr,#1
	moveq pc,lr
	bx lr
