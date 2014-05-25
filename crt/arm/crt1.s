.weak _init
.weak _fini
.global _start
.type _start,%function
_start:
	mov fp,#0
	mov lr,#0
	ldr a2,[sp],#4
	mov a3,sp
	ldr a4,=_fini
	str fp,[sp,#-4]!
	str a1,[sp,#-4]!
	str a4,[sp,#-4]!
	ldr a4,=_init
	ldr a1,=main
	bl __libc_start_main
1:	b 1b
