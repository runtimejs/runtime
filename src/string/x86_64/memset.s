.global memset
.type memset,@function
memset:
	and $0xff,%esi
	mov $0x101010101010101,%rax
	mov %rdx,%rcx
	mov %rdi,%r8
	imul %rsi,%rax
	cmp $16,%rcx
	jb 1f

	mov %rax,-8(%rdi,%rcx)
	shr $3,%rcx
	rep
	stosq
	mov %r8,%rax
	ret

1:	test %ecx,%ecx
	jz 1f

	mov %al,(%rdi)
	mov %al,-1(%rdi,%rcx)
	cmp $2,%ecx
	jbe 1f

	mov %al,1(%rdi)
	mov %al,-2(%rdi,%rcx)
	cmp $4,%ecx
	jbe 1f

	mov %eax,(%rdi)
	mov %eax,-4(%rdi,%rcx)
	cmp $8,%ecx
	jbe 1f

	mov %eax,4(%rdi)
	mov %eax,-8(%rdi,%rcx)

1:	mov %r8,%rax
	ret
