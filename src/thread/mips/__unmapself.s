.set noreorder
.global __unmapself
.type   __unmapself,@function
__unmapself:
	li $2, 4091
	syscall
	li $4, 0
	li $2, 4001
	syscall
