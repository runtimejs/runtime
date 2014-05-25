.hidden _DYNAMIC
.hidden __reloc_self
.set noreorder
.set nomacro
.global _start
.type _start,@function
_start:
	move $fp, $0

	bgezal $0, 1f
	nop
2:	.gpword 2b
	.gpword _DYNAMIC
	.gpword __reloc_self
1:	lw $gp, 0($ra)
	subu $gp, $ra, $gp

	lw $4, 0($sp)
	addiu $5, $sp, 4
	lw $6, 4($ra)
	addu $6, $6, $gp
	addiu $7, $gp, -0x7ff0
	subu $sp, $sp, 16
	lw $25, 8($ra)
	add $25, $25, $gp
	jalr $25
	nop

	lw $25, %call16(__dynlink)($gp)
	lw $4, 16($sp)
	addiu $5, $sp, 20
	jalr $25
	nop

	add $sp, $sp, 16
	li $6, -1
	lw $4, ($sp)
1:	lw $5, 4($sp)
	bne $5, $6, 2f
	nop
	addu $sp, $sp, 4
	addu $4, $4, -1
	b 1b
	nop
2:	sw $4, ($sp)
	jr $2
