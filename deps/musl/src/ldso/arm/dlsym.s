.text
.global dlsym
.type dlsym,%function
dlsym:
	mov r2,lr
	b __dlsym
