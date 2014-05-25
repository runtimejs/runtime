.text
.global __syscall_cp_asm
.type   __syscall_cp_asm, @function
__syscall_cp_asm:

.global __cp_begin
__cp_begin:
	mov.l @r4, r4
	tst   r4, r4
	bt    2f

	mov.l L1, r0
	braf  r0
	 nop
1:

.align 2
L1:	.long __cancel@PLT-(1b-.)

2:	mov   r5, r3
	mov   r6, r4
	mov   r7, r5
	mov.l @r15, r6
	mov.l @(4,r15), r7
	mov.l @(8,r15), r0
	mov.l @(12,r15), r1
	trapa #22

.global __cp_end
__cp_end:
	! work around hardware bug
	or   r0, r0
	or   r0, r0
	or   r0, r0
	or   r0, r0
	or   r0, r0

	rts
	 nop
