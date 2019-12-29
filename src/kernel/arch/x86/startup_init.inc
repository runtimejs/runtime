; Copyright 2014 runtime.js project authors
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

; 32 bit mode
use32

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
    finit

    xor edi, edi
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
IDTR32:
    dw SYSTEM_IDT_COUNT*SYSTEM_IDT_LEN_BYTES-1
    dq SYSTEM_IDT_TABLE_ADDR_32