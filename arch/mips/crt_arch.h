__asm__("\n\
.set push\n\
.set noreorder\n\
.global __start\n\
.global _start\n\
.type   __start, @function\n\
.type   _start, @function\n\
__start:\n\
_start:\n\
	bal 1f \n\
	move $fp, $0 \n\
2:	.gpword 2b \n\
1:	lw $gp, 0($ra) \n\
	subu $gp, $ra, $gp \n\
	move $4, $sp \n\
	subu $sp, $sp, 16 \n\
	and $sp, $sp, -8 \n\
	lw $25, %call16(__cstart)($gp) \n\
	jalr $25 \n\
	nop \n\
.set pop");
