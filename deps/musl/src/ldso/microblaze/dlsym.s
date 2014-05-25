.global dlsym
.type   dlsym,@function
dlsym:
	brid    __dlsym@PLT
	add     r7, r15, r0
