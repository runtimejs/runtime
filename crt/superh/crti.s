.section .init
.global  _init
.type    _init, @function
_init:
	sts.l pr, @-r15
	nop

.section .fini
.global  _fini
.type    _fini, @function
_fini:
	sts.l pr, @-r15
	nop
