.global fmod
.type fmod,@function
fmod:
	fldl 12(%esp)
	fldl 4(%esp)
1:	fprem
	fstsw %ax
	sahf
	jp 1b
	fstp %st(1)
	ret
