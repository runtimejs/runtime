.weak _init
.weak _fini
.global _start
_start:
	mov fp,#0
	mov lr,#0

	ldr a2,[sp],#4
	mov a3,sp
	str fp,[sp,#-4]!
	str a1,[sp,#-4]!

	adr ip,2f
	ldr a4,2f+4
	add a4,a4,ip
	str a4,[sp,#-4]!
	ldr a4,2f+8
	add a4,a4,ip

	ldr a1,2f
	add ip,ip,a1
	ldr a1,2f+12
	ldr a1,[ip,a1]

	bl __libc_start_main(PLT)
1:	b 1b
2:	.word _GLOBAL_OFFSET_TABLE_-2b
	.word _fini-2b
	.word _init-2b
	.word main(GOT)
