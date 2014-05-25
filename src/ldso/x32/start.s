.text
.global _start
_start:
	mov (%rsp),%rdi  /* move argc into 1st argument slot */
	lea 4(%rsp),%rsi /* move argv into 2nd argument slot */
	call __dynlink
	/* in case the dynlinker was called directly, it sets the "consumed"
	   argv values to -1. so we must loop over the array as long as -1
	   is in the top argv slot, decrement argc, and then set the stackpointer
	   to the new argc as well as argc's new value.
	   as the x32 abi has longs in the argv array, we cannot use push/pop.*/
	movl (%rsp),%edi /* copy argc into edi */
	xor %rdx,%rdx /* we use rdx as an offset to the current argv member */
1:	dec %edi
	addl $4, %edx
	movl (%rsp, %rdx), %esi
	cmp $-1,%esi
	jz 1b
	inc %edi
	subl $4, %edx
	lea (%rsp, %rdx), %rsp /* set rsp to new argv[-1] */
	movl %edi, (%rsp)      /* write new argc there */
	xor %edx,%edx
	jmp *%rax
