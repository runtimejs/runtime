; Copyright 2014 Runtime.JS project authors
;
; Licensed under the Apache License, Version 2.0 (the "License");
; you may not use this file except in compliance with the License.
; You may obtain a copy of the License at
;
;     http://www.apache.org/licenses/LICENSE-2.0
;
; Unless required by applicable law or agreed to in writing, software
; distributed under the License is distributed on an "AS IS" BASIS,
; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; See the License for the specific language governing permissions and
; limitations under the License.

format ELF64

THIS_LOADER_LOCATION = 0x8000
include 'startup_conf.inc'

section ".text" align 16

public _ap_startup_location
public _ap_startup_start
public _ap_startup_finish
public _cpus_counter

_ap_startup_location:

use16
org THIS_LOADER_LOCATION

_ap_startup_start:
    cli
    xor ax,ax
    mov ds,ax
    mov es,ax
    mov ss,ax
    mov fs,ax
    mov gs,ax
    jmp 0x0000:_cs_jump

_cs_jump:
    mov ax, 1
    lock xadd word [_cpus_counter], ax
    inc ax

    mov gs, ax

    lgdt [cs:GDTR32]

; Set protected mode
    mov eax, cr0
    or al, 0x01
    mov cr0, eax

    jmp 8:start32

align 16
_cpus_counter:
dq 0

use32

start32:
; Load data descriptor
    mov eax, 16

; Write to all segment registers (except GS)
    mov ds, ax
    mov es, ax
    mov ss, ax
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor esi, esi
    xor edi, edi
    xor ebp, ebp
    ;mov esp, 0x8000

; Initialize in 32 bit mode
    include 'startup_init.inc'

; Guard
    jmp $

align 16
GDTR32:
    dw gdt32_end - gdt32 - 1
    dq gdt32

align 16
gdt32:
    dw 0x0000, 0x0000, 0x0000, 0x0000	; NULL
    dw 0xFFFF, 0x0000, 0x9A00, 0x00CF	; CODE (32 bit)
    dw 0xFFFF, 0x0000, 0x9200, 0x00CF	; DATA (32 bit)
gdt32_end:

_ap_startup_finish:
dd 0
