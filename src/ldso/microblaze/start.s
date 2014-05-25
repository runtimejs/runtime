# FIXME: clearing argv entries
.global _start
_start:
	add     r19, r0, r0

	lw      r5, r0, r1
	addi    r6, r1, 4
	mfs     r7, rpc
	addi    r7, r7, _GLOBAL_OFFSET_TABLE_+8
	addi    r7, r7, _DYNAMIC@GOTOFF
	brlid   r15, __reloc_self@PLT
	addik   r1, r1, -16

	lwi     r5, r1, 16
	brlid   r15, __dynlink@PLT
	addi    r6, r1, 20
	addik   r1, r1, 16

	lwi     r4, r1, 0
1:	lwi     r5, r1, 4
	addi    r5, r5, 1
	bnei    r5, 1f
	addi    r4, r4, -1
	addi    r1, r1, 4
	bri     1b
1:	swi     r4, r1, 0
	add     r5, r0, r0
	bra     r3
