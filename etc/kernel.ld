ENTRY(main)
SECTIONS
{
    .loader 0x0000000000200000 :
    {
        *(.loader)
    }
    .text 0x0000000000201000 :
    {
        src/startup.o (.text)
        *(.text)
        *(.gnu.linkonce.t*)
        . = ALIGN(4096);
    }
    .rodata ALIGN (0x1000) :
    {
        start_ctors = .;
        KEEP (*(.preinit_array))
        KEEP (*(SORT(.ctors*)))
        KEEP (*(SORT(.ctor*)))
        KEEP (*(.init_array))
        KEEP (*(SORT(.init_array*)))
        end_ctors = .;

        start_dtors = .;
        *(SORT(.dtors.*))
        end_dtors = .;

        *(.rodata*)
        *(.gnu.linkonce.r*)
    }
    .data ALIGN (0x1000) :
    {
        *(.data)
        *(.gnu.linkonce.d*)
        . = ALIGN(4096);
    }
    .bss ALIGN (0x1000) :
    {
        *(COMMON)
        *(.bss*)
        *(.gnu.linkonce.b.*)
        . = ALIGN(4096);
    }

    /DISCARD/ :
    {
        *(.comment)
    }
    end = .; _end = .; __end = .;
}
