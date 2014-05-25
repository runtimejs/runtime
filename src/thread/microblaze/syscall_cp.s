.global __syscall_cp_asm
.type   __syscall_cp_asm,@function
__syscall_cp_asm:
.global __cp_begin
__cp_begin:
	lwi     r5, r5, 0
	bnei    r5, __cancel@PLT
	addi    r12, r6, 0
	add     r5, r7, r0
	add     r6, r8, r0
	add     r7, r9, r0
	add     r8, r10, r0
	lwi     r9, r1, 28
	lwi     r10, r1, 32
	brki    r14, 0x8
.global __cp_end
__cp_end:
	rtsd    r15, 8
	nop
