.global memset
.type memset,@function
memset:
	mov 8(%esp),%al
	push %edi
	mov %al,%ah
	mov %al,%dl
	mov 16(%esp),%ecx
	shl $16,%eax
	mov 8(%esp),%edi
	mov %dl,%al
	mov %dl,%ah
	cmp $16,%ecx
	jb 1f

	mov %eax,-4(%edi,%ecx)
	shr $2,%ecx
	rep
	stosl
	mov 8(%esp),%eax
	pop %edi
	ret

1:	test %ecx,%ecx
	jz 1f

	mov %al,(%edi)
	mov %al,-1(%edi,%ecx)
	cmp $2,%ecx
	jbe 1f

	mov %al,1(%edi)
	mov %al,-2(%edi,%ecx)
	cmp $4,%ecx
	jbe 1f

	mov %eax,(%edi)
	mov %eax,-4(%edi,%ecx)
	cmp $8,%ecx
	jbe 1f

	mov %eax,4(%edi)
	mov %eax,-8(%edi,%ecx)

1:	mov 8(%esp),%eax
	pop %edi
	ret
