.set noreorder

.section .init
.global _init
.align 2
_init:
	subu $sp,$sp,32
	sw $gp,24($sp)
	sw $ra,28($sp)

.section .fini
.global _fini
.align 2
_fini:
	subu $sp,$sp,32
	sw $gp,24($sp)
	sw $ra,28($sp)
