.global memmove
.type memmove,@function
memmove:
	mov %rdi,%rax
	sub %rsi,%rax
	cmp %rdx,%rax
	jae memcpy
	mov %rdx,%rcx
	lea -1(%rdi,%rdx),%rdi
	lea -1(%rsi,%rdx),%rsi
	std
	rep movsb
	cld
	lea 1(%rdi),%rax
	ret
