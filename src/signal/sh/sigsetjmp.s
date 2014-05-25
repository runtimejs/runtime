.global sigsetjmp
.global __sigsetjmp
.type sigsetjmp,@function
.type __sigsetjmp,@function
sigsetjmp:
__sigsetjmp:
	mov.l r5, @(36,r4)
	tst r5, r5
	bf  2f

	sts.l pr, @-r15
	mov.l r4, @-r15
	mov r4, r6
	add #40, r6
	mov #0, r5
	mov #2, r4
	mov.l L1, r0
	bsrf  r0
	 nop
1:	mov.l @r15+, r4
	lds.l @r15+, pr

2:	mov.l L2, r0
	braf  r0
	 nop
3:

.align 2
L1:	.long pthread_sigmask@PLT-(1b-.)
L2:	.long setjmp@PLT-(3b-.)
