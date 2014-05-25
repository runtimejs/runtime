; Copyright 2014, runtime.js project authors. All rights reserved.
; Use of this source code is governed by a BSD-style license that can be
; found in the LICENSE file.

format ELF64

THIS_LOADER_LOCATION = 0x200000

section ".loader"
use32
org THIS_LOADER_LOCATION

;=====================================================
; Constants
;=====================================================

include 'startup_conf.inc'

;=====================================================
; Multiboot structure
;=====================================================

_header:

dd MULTIBOOT_HEADER_MAGIC							; Magic
dd MULTIBOOT_HEADER_FLAGS							; Flags
dd -MULTIBOOT_HEADER_MAGIC-MULTIBOOT_HEADER_FLAGS	; Checksum
dd _header											; Header address
dd _header											; Data and Code start address
;dd _datacode_end									; Data and Code end address
;dd _end											; BSS end address
dd MULTIBOOT_LOAD_DATACODE_LEN
dd MULTIBOOT_LOAD_DATACODEBSS_LEN
dd _entry											; Entry address
dd 0  ;mode_type
dd 0  ;width
dd 0  ;height
dd 0  ;depth

;=====================================================
; Code
;=====================================================

_entry:

; Check loader (multiboot?)
    cmp eax, MULTIBOOT_LOADED_MAGIC
    jnz not_multiboot_loaded

; Save multiboot location
    mov dword [mbt], ebx

; Set 32bit stack
    mov esp, SYSTEM_STACK_32BIT

; Clear out the 4096 bytes of memory for 64-bit IDT
    mov ecx, 1024
    xor eax, eax
    mov edi, SYSTEM_IDT_TABLE_ADDR_64_32len
    rep stosd

; Clear memory for the Page Descriptor Entries
    mov edi, 0x00020000
    mov ecx, 65536
    rep stosd

; Copy the GDT to its final location in memory
    mov esi, gdt64
    mov edi, SYSTEM_GDT_TABLE_ADDR_64_32len		; GDT address
    mov ecx, (gdt64_end - gdt64)
    rep movsb									; Move it

; Create a PML4 entry
    cld
    mov edi, PAGING_PML4_ADDR
    mov eax, PAGING_PDP_ADDR+PAGING_PDP_OPTIONS
    stosd
    xor eax, eax
    stosd

; Single PDP entry can map 1GiB with 2MB pages
    mov ecx, PAGING_PDP_COUNT
    mov edi, PAGING_PDP_ADDR
    mov eax, PAGING_PD_ADDR+PAGING_PD_OPTIONS

mkpdpe:
    stosd
    push eax
    xor eax, eax
    stosd
    pop eax
    add eax, 0x00001000
    dec ecx
    cmp ecx, 0
    jne mkpdpe

; Create the PD entries
    mov edi, PAGING_PD_ADDR
    mov eax, PAGING_PHYS_PAGE_OPTIONS
    xor ecx, ecx

mkpd:
    stosd
    push eax
    xor eax, eax
    stosd
    pop eax
    add eax, 0x00200000
    inc ecx
    cmp ecx, PAGING_PD_COUNT
    jne mkpd

; Set current cpu #0 (BSP)
        xor ax, ax
        mov gs, ax

; Init system
include 'startup_init.inc'

use32
not_multiboot_loaded:
    mov eax, 'N M '
    mov [0x000B8000], eax
    jmp $

;=====================================================
; BSS Section. No more data or code below
;=====================================================
_datacode_end:
;=====================================================
; End of segments (nothing except label below)
;=====================================================
_end:
;=====================================================
; EOF
;=====================================================
