.section .init
	lds.l @r15+, pr
	rts
	 nop

.section .fini
	lds.l @r15+, pr
	rts
	 nop
