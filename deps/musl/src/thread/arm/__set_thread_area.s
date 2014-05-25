.text
.global __set_thread_area
.type   __set_thread_area,%function
__set_thread_area:
	mov r1,r7
	mov r7,#0x0f0000
	add r7,r7,#5
	svc 0
	mov r7,r1
	tst lr,#1
	moveq pc,lr
	bx lr
