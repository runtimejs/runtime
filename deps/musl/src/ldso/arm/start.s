.text
.global _start
_start:
	ldr r0,[sp]
	add r1,sp,#4
	bl __dynlink
	pop {r1}
1:	sub r1,r1,#1
	pop {r2}
	cmp r2,#-1
	beq 1b
	add r1,r1,#1
	push {r1,r2}
	mov r1,r0
	mov r0,#0
	tst r1,#1
	moveq pc,r1
	bx r1
