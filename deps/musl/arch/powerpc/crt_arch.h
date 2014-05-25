__asm__("\
.global _start \n\
.type   _start, %function \n\
_start: \n\
	mr 3, 1 \n\
	clrrwi 1, 1, 4 \n\
	li 0, 0 \n\
	stwu 1, -16(1) \n\
	mtlr 0 \n\
	stw 0, 0(1) \n\
	bl __cstart \n\
");        
