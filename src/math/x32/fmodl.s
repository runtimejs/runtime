.global fmodl
.type fmodl,@function
fmodl:
	fldt 24(%esp)
	fldt 8(%esp)
1:	fprem
	fstsw %ax
	sahf
	jp 1b
	fstp %st(1)
	ret
