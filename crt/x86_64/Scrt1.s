/* Written 2011 Nicholas J. Kain, released as Public Domain */
.weak _init
.weak _fini
.text
.global _start
_start:
	xor %rbp,%rbp   /* rbp:undefined -> mark as zero 0 (ABI) */
	mov %rdx,%r9    /* 6th arg: ptr to register with atexit() */
	pop %rsi        /* 2nd arg: argc */
	mov %rsp,%rdx   /* 3rd arg: argv */
	andq $-16,%rsp  /* align stack pointer */
	lea _fini(%rip),%r8           /* 5th arg: fini/dtors function */
	lea _init(%rip),%rcx          /* 4th arg: init/ctors function */
	mov main@GOTPCREL(%rip),%rdi  /* 1st arg: application entry ip */
	call __libc_start_main@PLT    /* musl init will run the program */
1:	jmp 1b
