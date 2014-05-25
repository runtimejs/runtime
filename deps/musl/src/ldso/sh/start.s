.text
.global _start
.type   _start, @function
_start:
	mov.l  @r15, r4
	mov    r15, r5
	mov.l  L1, r0
	bsrf   r0
	 add   #4, r5

2:	mov    r0, r2
	mov.l  @r15+, r1
1:	mov.l  @r15+, r0
	cmp/eq #-1, r0
	bt/s   1b
	 add   #-1, r1

	add    #1, r1
	mov.l  r0, @-r15
	mov.l  r1, @-r15
	mov    #0, r4
	jmp    @r2
	 nop

.align 2
L1:	.long __dynlink@PLT-(2b-.)
