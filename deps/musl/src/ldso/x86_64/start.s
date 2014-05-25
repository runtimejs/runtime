.text
.global _start
_start:
	mov (%rsp),%rdi
	lea 8(%rsp),%rsi
	call __dynlink
	pop %rdi
1:	dec %edi
	pop %rsi
	cmp $-1,%rsi
	jz 1b
	inc %edi
	push %rsi
	push %rdi
	xor %edx,%edx
	jmp *%rax
