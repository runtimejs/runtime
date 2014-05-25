.global __syscall_cp_asm
.type __syscall_cp_asm,%function
__syscall_cp_asm:
	mov ip,sp
	stmfd sp!,{r4,r5,r6,r7,lr}
.global __cp_begin
__cp_begin:
	ldr r0,[r0]
	cmp r0,#0
	blne __cancel
	mov r7,r1
	mov r0,r2
	mov r1,r3
	ldmfd ip,{r2,r3,r4,r5,r6}
	svc 0
.global __cp_end
__cp_end:
	ldmfd sp!,{r4,r5,r6,r7,lr}
	tst lr,#1
	moveq pc,lr
	bx lr
