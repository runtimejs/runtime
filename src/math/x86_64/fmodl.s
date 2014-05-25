.global fmodl
.type fmodl,@function
fmodl:
	fldt 24(%rsp)
	fldt 8(%rsp)
1:	fprem
	fstsw %ax
	sahf
	jp 1b
	fstp %st(1)
	ret
