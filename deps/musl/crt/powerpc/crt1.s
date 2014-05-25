        .weak  _init
        .weak  _fini
        .global _start
        .type   _start, %function
_start:
        mr      9, 1                  # Save the original stack pointer.
        clrrwi  1, 1, 4               # Align the stack to 16 bytes.
        lis     13, _SDA_BASE_@ha      # r13 points to the small data area.
        addi    13, 13, _SDA_BASE_@l  
        li      0, 0                   # Zero the frame pointer.
        stwu    1, -16(1)             # The initial stack frame.
        mtlr    0                      # Clear the link register.
        stw     0, 0(1)               # And save it.
        lis     3, main@ha             # Get main() ...
        addi    3, 3, main@l
        lwz     4, 0(9)               # and argc...
        addi    5, 9, 4               # and argv ...
        lis     6, _init@ha            # and _init() ...
        addi    6, 6, _init@l
        lis     7, _fini@ha            # and _fini() ...
        addi    7, 7, _fini@l
        li      8, 0                   # ldso_fini == NULL
        bl       __libc_start_main      # Let's go!
        b       .                       # Never gets here.
        .end    _start
        .size   _start, .-_start
