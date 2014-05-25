.global remainderl
.type remainderl,@function
remainderl:
	fldt 24(%esp)
	fldt 8(%esp)
1:	fprem1
	fstsw %ax
	sahf
	jp 1b
	fstp %st(1)
	ret
