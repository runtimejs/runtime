	.global sigsetjmp
	.global __sigsetjmp
	.type sigsetjmp,%function
	.type __sigsetjmp,%function
sigsetjmp:
__sigsetjmp:
	#int sigsetjmp(sigjmp_buf buf, int save)
	#		r3		r4
	#0) store save into buf->__fl
	stw 4, 448(3)
	#1) compare save with 0
	cmpwi cr7, 4, 0
	#2) if its 0, goto setjmp code
	beq- cr7, 1f
	#3) else: we must call pthread_sigmask(SIG_SETMASK, 0, (sigset_t *)buf->__ss);
	# store non-volatile regs 30, 31 into the setjmp buf
	stw 30, 0(3)
	stw 31, 4(3)
	# use them to store the pointer to the jmpbuf and the link reg
	mr 30, 3
	mflr 31
	
	# put pointer to ss buf into r5 (3rd arg)
	addi 5, 3, 452
	# put "2" i.e. SIG_SETMASK in r3
	li 3, 2
	li 4, 0
	bl pthread_sigmask
	
	#restore jmpbuf pointer and link reg
	mr 3, 30
	mtlr 31
	#resore non-volatile regs
	lwz 30, 0(3)
	lwz 31, 4(3)

1:
	b setjmp
