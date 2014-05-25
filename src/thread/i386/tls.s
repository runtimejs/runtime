.text
.global ___tls_get_addr
.type ___tls_get_addr,@function
___tls_get_addr:
	push %eax
	call __tls_get_addr
	pop %edx
	ret
