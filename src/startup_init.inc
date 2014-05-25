; Copyright 2014, runtime.js project authors. All rights reserved.
; Use of this source code is governed by a BSD-style license that can be
; found in the LICENSE file.

; 32 bit mode
use32

; Load the GDT
    lgdt [GDTR64]

; Enable CR4.PAE (bit 5)
    mov eax, cr4
    or eax, 0x000000020
    mov cr4, eax

; Setup CR3, write PML4 location
    mov eax, PAGING_PML4_ADDR+PAGING_PML4_OPTIONS
    mov cr3, eax

; Enable long mode (EFER.LME=1)
    mov ecx, 0xC0000080
    rdmsr
    or eax, 0x00000100
    wrmsr

; Enable paging, this will activate long mode
    mov eax, cr0
    or eax, 0x80000000
    mov cr0, eax

; Jump to 64 bit mode
    jmp SYS64_CODE_SEL:start64

align 16

; 64 bit mode
use64
start64:

; Setup registers
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    xor rsi, rsi
    xor rdi, rdi
    xor rbp, rbp

; Setup stack using GS as ID of CPU
; 64 KiB each stack (<< 16)
    mov ax, gs
    shl eax, 16
    mov ebx, SYSTEM_STACK_64BIT
    sub ebx, eax
    xor rsp, rsp
    mov esp, ebx

; Cleanup
    xor rax, rax
    xor rbx, rbx
    xor r8, r8
    xor r9, r9
    xor r10, r10
    xor r11, r11
    xor r12, r12
    xor r13, r13
    xor r14, r14
    xor r15, r15

; Segment registers cleanup
; Do not touch GS
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov fs, ax

; Another 64 bit jump
    mov rax, clearcs64
    jmp rax
    nop

clearcs64:
    xor rax, rax

; Reload the GDT
    lgdt [GDTR64]

; Load IDT, no vectors setup at the moment
    lidt [IDTR64]

; Enable Floating Point, setup cache
    mov rax, cr0
    bts rax, 1			; Set Monitor co-processor (Bit 1)
    btr rax, 2			; Clear Emulation (Bit 2)
    bts rax, 16         ; Set write protect bit
    btr rax, 30         ; Clear Cache disable
    btr rax, 29         ; Clear Not Write Through
    mov cr0, rax

; Enable SSE
    mov rax, cr4
    bts rax, 9			; FXSAVE and FXSTOR instructions (Bit 9)
    bts rax, 10			; SIMD Floating-Point Exceptions (Bit 10)
    mov cr4, rax

    fldcw [value_37F]   ; writes 0x37f into the control word: the value written by F(N)INIT
    fldcw [value_37E]   ; writes 0x37e, the default with invalid operand exceptions enabled
    fldcw [value_37A]   ; writes 0x37a, both division by zero and invalid operands cause exceptions.

; Enable Math Co-processor
    finit

; Jump to C++ kernel entry point
    xor rdi, rdi
    mov edi, dword [mbt]
    jmp 0x201000

; Guard
    jmp $

;=====================================================
; Data
;=====================================================
_data:

align 16
value_37F:		dw 0x37F
value_37E:		dw 0x37E
value_37A:		dw 0x37A
mbt: 			dd 0

align 16
GDTR64:
    dw gdt64_end - gdt64 - 1
    dq SYSTEM_GDT_TABLE_ADDR_64

align 16
gdt64:
SYS64_NULL_SEL = $-gdt64		; NULL
    dq 0x0000000000000000
SYS64_CODE_SEL = $-gdt64		; CODE, RX, nonconforming
    dq 0x0020980000000000
SYS64_DATA_SEL = $-gdt64		; DATA, RW, expand down
    dq 0x0000900000000000
gdt64_end:

align 16
IDTR64:
    dw SYSTEM_IDT_COUNT*SYSTEM_IDT_LEN_BYTES-1
    dq SYSTEM_IDT_TABLE_ADDR_64
