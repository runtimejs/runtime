.set noreorder

.weak  _init
.weak  _fini
.global __start
.global _start
__start:
_start:
	subu    $fp, $fp, $fp            # Zero the frame pointer.
	lui     $gp, %hi(_gp)
	addi    $gp, %lo(_gp)
	#la      $gp, _gp
	lw      $4, %call16(main)($gp)   # Get main() ...
	lw      $5, ($sp)                # Get argc...
	addu    $6, $sp, 4               # and argv ...
	lw      $7, %call16(_init)($gp)  # and _init() ...
	and     $sp, $sp, -8             # Align the stack pointer to 8 bytes
	addi    $sp, $sp, -4*6           # Leave space for arguments 0..3, arg4, and arg5.
	lw      $12, %call16(_fini)($gp) # and _fini() ...
	sw      $12, 4*4($sp)            # Save arg4.
	sw      $0, 4*5($sp)             # ldso_fini == NULL
	lw      $25, %call16(__libc_start_main)($gp)
	jalr    $25                      # Let's go!
	nop
	b       .                        # Never gets here.
	nop
