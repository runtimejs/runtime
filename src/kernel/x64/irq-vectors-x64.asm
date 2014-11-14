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

section ".text" align 16
use64

public   _preemptStart as 'preemptStart'
public   _threadStructInit as 'threadStructInit'
public   _enterFirstThread as 'enterFirstThread'

public	 _int_gate_exception_DE as 'int_gate_exception_DE'
public	 _int_gate_exception_DB as 'int_gate_exception_DB'
public	 _int_gate_exception_NMI as 'int_gate_exception_NMI'
public	 _int_gate_exception_BP as 'int_gate_exception_BP'
public	 _int_gate_exception_OF as 'int_gate_exception_OF'
public	 _int_gate_exception_BR as 'int_gate_exception_BR'
public	 _int_gate_exception_UD as 'int_gate_exception_UD'
public	 _int_gate_exception_NM as 'int_gate_exception_NM'
public	 _int_gate_exception_DF as 'int_gate_exception_DF'
public	 _int_gate_exception_TS as 'int_gate_exception_TS'
public	 _int_gate_exception_NP as 'int_gate_exception_NP'
public	 _int_gate_exception_SS as 'int_gate_exception_SS'
public	 _int_gate_exception_GP as 'int_gate_exception_GP'
public	 _int_gate_exception_PF as 'int_gate_exception_PF'
public	 _int_gate_exception_MF as 'int_gate_exception_MF'
public	 _int_gate_exception_AC as 'int_gate_exception_AC'
public	 _int_gate_exception_MC as 'int_gate_exception_MC'
public	 _int_gate_exception_XF as 'int_gate_exception_XF'
public	 _int_gate_exception_SX as 'int_gate_exception_SX'
public	 _int_gate_exception_other as 'int_gate_exception_other'

public   _int_gate_irq_timer as 'int_gate_irq_timer'
public   _int_gate_irq_keyboard as 'int_gate_irq_keyboard'
public   _int_gate_irq_spurious as 'int_gate_irq_spurious'

public   _switch_to_stack as 'switch_to_stack'

public _irq_gate_20
public _irq_gate_21
public _irq_gate_22
public _irq_gate_23
public _irq_gate_24
public _irq_gate_25
public _irq_gate_26
public _irq_gate_27
public _irq_gate_28
public _irq_gate_29
public _irq_gate_2a
public _irq_gate_2b
public _irq_gate_2c
public _irq_gate_2d
public _irq_gate_2e
public _irq_gate_2f
public _irq_gate_30
public _irq_gate_31
public _irq_gate_32
public _irq_gate_33
public _irq_gate_34
public _irq_gate_35
public _irq_gate_36
public _irq_gate_37
public _irq_gate_38
public _irq_gate_39
public _irq_gate_3a
public _irq_gate_3b
public _irq_gate_3c
public _irq_gate_3d
public _irq_gate_3e
public _irq_gate_3f
public _irq_gate_40
public _irq_gate_41
public _irq_gate_42
public _irq_gate_43
public _irq_gate_44
public _irq_gate_45
public _irq_gate_46
public _irq_gate_47
public _irq_gate_48
public _irq_gate_49
public _irq_gate_4a
public _irq_gate_4b
public _irq_gate_4c
public _irq_gate_4d
public _irq_gate_4e
public _irq_gate_4f
public _irq_gate_50
public _irq_gate_51
public _irq_gate_52
public _irq_gate_53
public _irq_gate_54
public _irq_gate_55
public _irq_gate_56
public _irq_gate_57
public _irq_gate_58
public _irq_gate_59
public _irq_gate_5a
public _irq_gate_5b
public _irq_gate_5c
public _irq_gate_5d
public _irq_gate_5e
public _irq_gate_5f
public _irq_gate_60
public _irq_gate_61
public _irq_gate_62
public _irq_gate_63
public _irq_gate_64
public _irq_gate_65
public _irq_gate_66
public _irq_gate_67
public _irq_gate_68
public _irq_gate_69
public _irq_gate_6a
public _irq_gate_6b
public _irq_gate_6c
public _irq_gate_6d
public _irq_gate_6e
public _irq_gate_6f
public _irq_gate_70
public _irq_gate_71
public _irq_gate_72
public _irq_gate_73
public _irq_gate_74
public _irq_gate_75
public _irq_gate_76
public _irq_gate_77
public _irq_gate_78
public _irq_gate_79
public _irq_gate_7a
public _irq_gate_7b
public _irq_gate_7c
public _irq_gate_7d
public _irq_gate_7e
public _irq_gate_7f
public _irq_gate_80
public _irq_gate_81
public _irq_gate_82
public _irq_gate_83
public _irq_gate_84
public _irq_gate_85
public _irq_gate_86
public _irq_gate_87
public _irq_gate_88
public _irq_gate_89
public _irq_gate_8a
public _irq_gate_8b
public _irq_gate_8c
public _irq_gate_8d
public _irq_gate_8e
public _irq_gate_8f
public _irq_gate_90
public _irq_gate_91
public _irq_gate_92
public _irq_gate_93
public _irq_gate_94
public _irq_gate_95
public _irq_gate_96
public _irq_gate_97
public _irq_gate_98
public _irq_gate_99
public _irq_gate_9a
public _irq_gate_9b
public _irq_gate_9c
public _irq_gate_9d
public _irq_gate_9e
public _irq_gate_9f
public _irq_gate_a0
public _irq_gate_a1
public _irq_gate_a2
public _irq_gate_a3
public _irq_gate_a4
public _irq_gate_a5
public _irq_gate_a6
public _irq_gate_a7
public _irq_gate_a8
public _irq_gate_a9
public _irq_gate_aa
public _irq_gate_ab
public _irq_gate_ac
public _irq_gate_ad
public _irq_gate_ae
public _irq_gate_af
public _irq_gate_b0
public _irq_gate_b1
public _irq_gate_b2
public _irq_gate_b3
public _irq_gate_b4
public _irq_gate_b5
public _irq_gate_b6
public _irq_gate_b7
public _irq_gate_b8
public _irq_gate_b9
public _irq_gate_ba
public _irq_gate_bb
public _irq_gate_bc
public _irq_gate_bd
public _irq_gate_be
public _irq_gate_bf
public _irq_gate_c0
public _irq_gate_c1
public _irq_gate_c2
public _irq_gate_c3
public _irq_gate_c4
public _irq_gate_c5
public _irq_gate_c6
public _irq_gate_c7
public _irq_gate_c8
public _irq_gate_c9
public _irq_gate_ca
public _irq_gate_cb
public _irq_gate_cc
public _irq_gate_cd
public _irq_gate_ce
public _irq_gate_cf
public _irq_gate_d0
public _irq_gate_d1
public _irq_gate_d2
public _irq_gate_d3
public _irq_gate_d4
public _irq_gate_d5
public _irq_gate_d6
public _irq_gate_d7
public _irq_gate_d8
public _irq_gate_d9
public _irq_gate_da
public _irq_gate_db
public _irq_gate_dc
public _irq_gate_dd
public _irq_gate_de
public _irq_gate_df
public _irq_gate_e0
public _irq_gate_e1
public _irq_gate_e2
public _irq_gate_e3
public _irq_gate_e4
public _irq_gate_e5
public _irq_gate_e6
public _irq_gate_e7
public _irq_gate_e8
public _irq_gate_e9
public _irq_gate_ea
public _irq_gate_eb
public _irq_gate_ec
public _irq_gate_ed
public _irq_gate_ee
public _irq_gate_ef
public _irq_gate_f0
public _irq_gate_f1
public _irq_gate_f2
public _irq_gate_f3
public _irq_gate_f4
public _irq_gate_f5
public _irq_gate_f6
public _irq_gate_f7
public _irq_gate_f8
public _irq_gate_f9
public _irq_gate_fa
public _irq_gate_fb
public _irq_gate_fc
public _irq_gate_fd
public _irq_gate_fe


extrn	 exception_DE_event
extrn	 exception_DB_event
extrn	 exception_NMI_event
extrn	 exception_BP_event
extrn	 exception_OF_event
extrn	 exception_BR_event
extrn	 exception_UD_event
extrn	 exception_NM_event
extrn	 exception_DF_event
extrn	 exception_TS_event
extrn	 exception_NP_event
extrn	 exception_SS_event
extrn	 exception_GP_event
extrn	 exception_PF_event
extrn	 exception_MF_event
extrn	 exception_AC_event
extrn	 exception_MC_event
extrn	 exception_XF_event
extrn	 exception_SX_event
extrn	 exception_other_event

extrn    irq_timer_event
extrn    irq_keyboard_event
extrn    irq_other_event
extrn    irq_handler_any

macro SaveState
{
    sub rsp, 256
    mov qword [rsp+0], r15
    mov qword [rsp+8], r14
    mov qword [rsp+16], r13
    mov qword [rsp+24], r12
    mov qword [rsp+32], r11
    mov qword [rsp+40], r10
    mov qword [rsp+48], r9
    mov qword [rsp+56], r8
    mov qword [rsp+64], rdi
    mov qword [rsp+72], rsi
    mov qword [rsp+80], rdx
    mov qword [rsp+88], rcx
    mov qword [rsp+96], rbx
    mov qword [rsp+104], rax
    mov qword [rsp+112], rbp
    mov qword [rsp+120], rsp
}

macro RestoreState
{
    mov r15, qword [rsp+0]
    mov r14, qword [rsp+8]
    mov r13, qword [rsp+16]
    mov r12, qword [rsp+24]
    mov r11, qword [rsp+32]
    mov r10, qword [rsp+40]
    mov r9, qword [rsp+48]
    mov r8, qword [rsp+56]
    mov rdi, qword [rsp+64]
    mov rsi, qword [rsp+72]
    mov rdx, qword [rsp+80]
    mov rcx, qword [rsp+88]
    mov rbx, qword [rsp+96]
    mov rax, qword [rsp+104]
    mov rbp, qword [rsp+112]
    mov rsp, qword [rsp+120]
    add rsp, 256
}

macro IrqHandler num
{
    SaveState
    mov rdi, num
    call irq_handler_any
    RestoreState
    iretq
}

macro Hang
{
    jmp $
}

; rdi containts first argument - stack pointer
; rsi containts second argument - address to jump
_switch_to_stack:

    xor rax,rax
    push rax    ; target ss
    push rdi    ; target rsp
    pushfq      ; target flags
    push rax    ; target cs
    push rsi    ; target rip
    iretq

;  ---------------------------------------------------
;  begin preempt logic

;  Param: RDI - load thread structure location, 16 bytes aligned
;               structure size - 1024 bytes
;                 0 - 512  fx state
;               512 - 1024 general registers etc

_enterFirstThread:

    xor rax, rax
    push rax                    ; target ss
    push qword [rdi+560]        ; target rsp
    pushfq                      ; target flags
    push 0x08                   ; target cs
    push qword [rdi+568]        ; target rip
    mov rdi, qword [rdi+576]    ; pass thread pointer as 1st parameter
    iretq

;
;  Param: RDI - save thread structure location, 16 bytes aligned
;               structure size - 1024 bytes
;                 0 - 512  fx state
;               512 - 1024 general registers etc
;  Param: RSI - load thread structure location, 16 bytes aligned
;               structure size - 1024 bytes
;                 0 - 512  fx state
;               512 - 1024 general registers etc
;

_preemptStart:
    cli
    push rdi
    fxsave [rdi]
    mov qword [rdi+512], r15
    mov qword [rdi+520], r14
    mov qword [rdi+528], r13
    mov qword [rdi+536], r12
    mov qword [rdi+544], rbp
    mov qword [rdi+552], rbx
    mov qword [rdi+560], rsp
    mov qword [rdi+568], _preemptCallback

    xor rax, rax
    push rax                    ; target ss
    push qword [rsi+560]        ; target rsp
    pushfq                      ; target flags
    push 0x08                   ; target cs
    push qword [rsi+568]        ; target rip
    mov rdi, qword [rsi+576]    ; pass thread pointer as 1st parameter
    iretq

_preemptCallback:
    pop rdi
    fxrstor [rdi]
    mov r15, qword [rdi+512]
    mov r14, qword [rdi+520]
    mov r13, qword [rdi+528]
    mov r12, qword [rdi+536]
    mov rbp, qword [rdi+544]
    mov rbx, qword [rdi+552]
    mov rax, qword [rdi+576]   ; return thread pointer
    sti
    ret

;  Param: RDI - clean 1024 byte space for thread structure location
;  Param: RSI - function pointer to thread entry point
;  Param: RDX - thread stack location
;  Param: RCX - thread object pointer

_threadStructInit:
    fxsave [rdi]        ; save current state, it could be any valid fxstate
    xor rax, rax
    mov qword [rdi+512], rax
    mov qword [rdi+520], rax
    mov qword [rdi+528], rax
    mov qword [rdi+536], rax
    mov qword [rdi+544], rax
    mov qword [rdi+552], rax
    mov qword [rdi+560], rdx
    mov qword [rdi+568], rsi
    mov qword [rdi+576], rcx
    ret

;  end preempt logic
;  ---------------------------------------------------

_int_gate_exception_DE:

    SaveState
    call	exception_DE_event
    RestoreState
    Hang

_int_gate_exception_DB:

    SaveState
    call	exception_DB_event
    RestoreState
    Hang

_int_gate_exception_NMI:

    SaveState
    call	exception_NMI_event
    RestoreState
    Hang

_int_gate_exception_BP:

    SaveState
    call	exception_BP_event
    RestoreState
    Hang

_int_gate_exception_OF:

    SaveState
    call	exception_OF_event
    RestoreState
    Hang

_int_gate_exception_BR:

    SaveState
    call	exception_BR_event
    RestoreState
    Hang

_int_gate_exception_UD:

    pop rdi ; rip, 1 arg
    pop rsi ; cs, 2 arg
    SaveState
    call	exception_UD_event
    RestoreState
    Hang

_int_gate_exception_NM:

    SaveState
    call	exception_NM_event
    RestoreState
    Hang

_int_gate_exception_DF:

    SaveState
    call	exception_DF_event
    RestoreState
    Hang

_int_gate_exception_TS:

    SaveState
    call	exception_TS_event
    RestoreState
    Hang

_int_gate_exception_NP:

    SaveState
    call	exception_NP_event
    RestoreState
    Hang

_int_gate_exception_SS:

    SaveState
    call	exception_SS_event
    RestoreState
    Hang

_int_gate_exception_GP:

    pop rdx ; error code, 3arg
    pop rdi ; rip, 1 arg
    pop rsi ; cs, 2 arg
    pop rbx ; remove flags
    pop rbx ; remore rsp
    pop rbx ; remove ss
    mov rcx, rax  ; save rax, 4 arg

    SaveState
    call	exception_GP_event
    RestoreState
    cli
    hlt
    iretq

_int_gate_exception_PF:

    SaveState
    mov rsi, 0
    mov     rdi, cr2    ; CR2 contians the address that the program tried to access
    call    exception_PF_event
    RestoreState
    add	rsp, 8	    ; fix rsp after state restore
    iretq

_int_gate_exception_MF:

    SaveState
    call	exception_MF_event
    RestoreState
    Hang

_int_gate_exception_AC:

    SaveState
    call	exception_AC_event
    RestoreState
    Hang

_int_gate_exception_MC:

    SaveState
    call	exception_MC_event
    RestoreState
    Hang

_int_gate_exception_XF:

    SaveState
    call	exception_XF_event
    RestoreState
    Hang

_int_gate_exception_SX:

    SaveState
    call	exception_SX_event
    RestoreState
    Hang

_int_gate_exception_other:

    SaveState
    call	exception_other_event
    RestoreState
    Hang

align 16

_int_gate_irq_timer:

    SaveState
    mov rdi, rsp 	; arg 0
    add rdi, 256
    mov rdx, [rdi] 	; arg 2, rip from stack
    add rdi, 40		; compute sp, exclude cpu saved state (5*qword)
    mov rsi, rbp 	; arg 1
    call    irq_timer_event
    RestoreState
    iretq

align 16
_int_gate_irq_keyboard:

    ; debugging
    ; pop rdi  ; place RIP into first argument
    ; push rdi ; put it back

    SaveState
    call    irq_keyboard_event
    RestoreState
    iretq

align 16
_irq_gate_20: IrqHandler 0x0
_irq_gate_21: IrqHandler 0x1
_irq_gate_22: IrqHandler 0x2
_irq_gate_23: IrqHandler 0x3
_irq_gate_24: IrqHandler 0x4
_irq_gate_25: IrqHandler 0x5
_irq_gate_26: IrqHandler 0x6
_irq_gate_27: IrqHandler 0x7
_irq_gate_28: IrqHandler 0x8
_irq_gate_29: IrqHandler 0x9
_irq_gate_2a: IrqHandler 0xa
_irq_gate_2b: IrqHandler 0xb
_irq_gate_2c: IrqHandler 0xc
_irq_gate_2d: IrqHandler 0xd
_irq_gate_2e: IrqHandler 0xe
_irq_gate_2f: IrqHandler 0xf
_irq_gate_30: IrqHandler 0x10
_irq_gate_31: IrqHandler 0x11
_irq_gate_32: IrqHandler 0x12
_irq_gate_33: IrqHandler 0x13
_irq_gate_34: IrqHandler 0x14
_irq_gate_35: IrqHandler 0x15
_irq_gate_36: IrqHandler 0x16
_irq_gate_37: IrqHandler 0x17
_irq_gate_38: IrqHandler 0x18
_irq_gate_39: IrqHandler 0x19
_irq_gate_3a: IrqHandler 0x1a
_irq_gate_3b: IrqHandler 0x1b
_irq_gate_3c: IrqHandler 0x1c
_irq_gate_3d: IrqHandler 0x1d
_irq_gate_3e: IrqHandler 0x1e
_irq_gate_3f: IrqHandler 0x1f
_irq_gate_40: IrqHandler 0x20
_irq_gate_41: IrqHandler 0x21
_irq_gate_42: IrqHandler 0x22
_irq_gate_43: IrqHandler 0x23
_irq_gate_44: IrqHandler 0x24
_irq_gate_45: IrqHandler 0x25
_irq_gate_46: IrqHandler 0x26
_irq_gate_47: IrqHandler 0x27
_irq_gate_48: IrqHandler 0x28
_irq_gate_49: IrqHandler 0x29
_irq_gate_4a: IrqHandler 0x2a
_irq_gate_4b: IrqHandler 0x2b
_irq_gate_4c: IrqHandler 0x2c
_irq_gate_4d: IrqHandler 0x2d
_irq_gate_4e: IrqHandler 0x2e
_irq_gate_4f: IrqHandler 0x2f
_irq_gate_50: IrqHandler 0x30
_irq_gate_51: IrqHandler 0x31
_irq_gate_52: IrqHandler 0x32
_irq_gate_53: IrqHandler 0x33
_irq_gate_54: IrqHandler 0x34
_irq_gate_55: IrqHandler 0x35
_irq_gate_56: IrqHandler 0x36
_irq_gate_57: IrqHandler 0x37
_irq_gate_58: IrqHandler 0x38
_irq_gate_59: IrqHandler 0x39
_irq_gate_5a: IrqHandler 0x3a
_irq_gate_5b: IrqHandler 0x3b
_irq_gate_5c: IrqHandler 0x3c
_irq_gate_5d: IrqHandler 0x3d
_irq_gate_5e: IrqHandler 0x3e
_irq_gate_5f: IrqHandler 0x3f
_irq_gate_60: IrqHandler 0x40
_irq_gate_61: IrqHandler 0x41
_irq_gate_62: IrqHandler 0x42
_irq_gate_63: IrqHandler 0x43
_irq_gate_64: IrqHandler 0x44
_irq_gate_65: IrqHandler 0x45
_irq_gate_66: IrqHandler 0x46
_irq_gate_67: IrqHandler 0x47
_irq_gate_68: IrqHandler 0x48
_irq_gate_69: IrqHandler 0x49
_irq_gate_6a: IrqHandler 0x4a
_irq_gate_6b: IrqHandler 0x4b
_irq_gate_6c: IrqHandler 0x4c
_irq_gate_6d: IrqHandler 0x4d
_irq_gate_6e: IrqHandler 0x4e
_irq_gate_6f: IrqHandler 0x4f
_irq_gate_70: IrqHandler 0x50
_irq_gate_71: IrqHandler 0x51
_irq_gate_72: IrqHandler 0x52
_irq_gate_73: IrqHandler 0x53
_irq_gate_74: IrqHandler 0x54
_irq_gate_75: IrqHandler 0x55
_irq_gate_76: IrqHandler 0x56
_irq_gate_77: IrqHandler 0x57
_irq_gate_78: IrqHandler 0x58
_irq_gate_79: IrqHandler 0x59
_irq_gate_7a: IrqHandler 0x5a
_irq_gate_7b: IrqHandler 0x5b
_irq_gate_7c: IrqHandler 0x5c
_irq_gate_7d: IrqHandler 0x5d
_irq_gate_7e: IrqHandler 0x5e
_irq_gate_7f: IrqHandler 0x5f
_irq_gate_80: IrqHandler 0x60
_irq_gate_81: IrqHandler 0x61
_irq_gate_82: IrqHandler 0x62
_irq_gate_83: IrqHandler 0x63
_irq_gate_84: IrqHandler 0x64
_irq_gate_85: IrqHandler 0x65
_irq_gate_86: IrqHandler 0x66
_irq_gate_87: IrqHandler 0x67
_irq_gate_88: IrqHandler 0x68
_irq_gate_89: IrqHandler 0x69
_irq_gate_8a: IrqHandler 0x6a
_irq_gate_8b: IrqHandler 0x6b
_irq_gate_8c: IrqHandler 0x6c
_irq_gate_8d: IrqHandler 0x6d
_irq_gate_8e: IrqHandler 0x6e
_irq_gate_8f: IrqHandler 0x6f
_irq_gate_90: IrqHandler 0x70
_irq_gate_91: IrqHandler 0x71
_irq_gate_92: IrqHandler 0x72
_irq_gate_93: IrqHandler 0x73
_irq_gate_94: IrqHandler 0x74
_irq_gate_95: IrqHandler 0x75
_irq_gate_96: IrqHandler 0x76
_irq_gate_97: IrqHandler 0x77
_irq_gate_98: IrqHandler 0x78
_irq_gate_99: IrqHandler 0x79
_irq_gate_9a: IrqHandler 0x7a
_irq_gate_9b: IrqHandler 0x7b
_irq_gate_9c: IrqHandler 0x7c
_irq_gate_9d: IrqHandler 0x7d
_irq_gate_9e: IrqHandler 0x7e
_irq_gate_9f: IrqHandler 0x7f
_irq_gate_a0: IrqHandler 0x80
_irq_gate_a1: IrqHandler 0x81
_irq_gate_a2: IrqHandler 0x82
_irq_gate_a3: IrqHandler 0x83
_irq_gate_a4: IrqHandler 0x84
_irq_gate_a5: IrqHandler 0x85
_irq_gate_a6: IrqHandler 0x86
_irq_gate_a7: IrqHandler 0x87
_irq_gate_a8: IrqHandler 0x88
_irq_gate_a9: IrqHandler 0x89
_irq_gate_aa: IrqHandler 0x8a
_irq_gate_ab: IrqHandler 0x8b
_irq_gate_ac: IrqHandler 0x8c
_irq_gate_ad: IrqHandler 0x8d
_irq_gate_ae: IrqHandler 0x8e
_irq_gate_af: IrqHandler 0x8f
_irq_gate_b0: IrqHandler 0x90
_irq_gate_b1: IrqHandler 0x91
_irq_gate_b2: IrqHandler 0x92
_irq_gate_b3: IrqHandler 0x93
_irq_gate_b4: IrqHandler 0x94
_irq_gate_b5: IrqHandler 0x95
_irq_gate_b6: IrqHandler 0x96
_irq_gate_b7: IrqHandler 0x97
_irq_gate_b8: IrqHandler 0x98
_irq_gate_b9: IrqHandler 0x99
_irq_gate_ba: IrqHandler 0x9a
_irq_gate_bb: IrqHandler 0x9b
_irq_gate_bc: IrqHandler 0x9c
_irq_gate_bd: IrqHandler 0x9d
_irq_gate_be: IrqHandler 0x9e
_irq_gate_bf: IrqHandler 0x9f
_irq_gate_c0: IrqHandler 0xa0
_irq_gate_c1: IrqHandler 0xa1
_irq_gate_c2: IrqHandler 0xa2
_irq_gate_c3: IrqHandler 0xa3
_irq_gate_c4: IrqHandler 0xa4
_irq_gate_c5: IrqHandler 0xa5
_irq_gate_c6: IrqHandler 0xa6
_irq_gate_c7: IrqHandler 0xa7
_irq_gate_c8: IrqHandler 0xa8
_irq_gate_c9: IrqHandler 0xa9
_irq_gate_ca: IrqHandler 0xaa
_irq_gate_cb: IrqHandler 0xab
_irq_gate_cc: IrqHandler 0xac
_irq_gate_cd: IrqHandler 0xad
_irq_gate_ce: IrqHandler 0xae
_irq_gate_cf: IrqHandler 0xaf
_irq_gate_d0: IrqHandler 0xb0
_irq_gate_d1: IrqHandler 0xb1
_irq_gate_d2: IrqHandler 0xb2
_irq_gate_d3: IrqHandler 0xb3
_irq_gate_d4: IrqHandler 0xb4
_irq_gate_d5: IrqHandler 0xb5
_irq_gate_d6: IrqHandler 0xb6
_irq_gate_d7: IrqHandler 0xb7
_irq_gate_d8: IrqHandler 0xb8
_irq_gate_d9: IrqHandler 0xb9
_irq_gate_da: IrqHandler 0xba
_irq_gate_db: IrqHandler 0xbb
_irq_gate_dc: IrqHandler 0xbc
_irq_gate_dd: IrqHandler 0xbd
_irq_gate_de: IrqHandler 0xbe
_irq_gate_df: IrqHandler 0xbf
_irq_gate_e0: IrqHandler 0xc0
_irq_gate_e1: IrqHandler 0xc1
_irq_gate_e2: IrqHandler 0xc2
_irq_gate_e3: IrqHandler 0xc3
_irq_gate_e4: IrqHandler 0xc4
_irq_gate_e5: IrqHandler 0xc5
_irq_gate_e6: IrqHandler 0xc6
_irq_gate_e7: IrqHandler 0xc7
_irq_gate_e8: IrqHandler 0xc8
_irq_gate_e9: IrqHandler 0xc9
_irq_gate_ea: IrqHandler 0xca
_irq_gate_eb: IrqHandler 0xcb
_irq_gate_ec: IrqHandler 0xcc
_irq_gate_ed: IrqHandler 0xcd
_irq_gate_ee: IrqHandler 0xce
_irq_gate_ef: IrqHandler 0xcf
_irq_gate_f0: IrqHandler 0xd0
_irq_gate_f1: IrqHandler 0xd1
_irq_gate_f2: IrqHandler 0xd2
_irq_gate_f3: IrqHandler 0xd3
_irq_gate_f4: IrqHandler 0xd4
_irq_gate_f5: IrqHandler 0xd5
_irq_gate_f6: IrqHandler 0xd6
_irq_gate_f7: IrqHandler 0xd7
_irq_gate_f8: IrqHandler 0xd8
_irq_gate_f9: IrqHandler 0xd9
_irq_gate_fa: IrqHandler 0xda
_irq_gate_fb: IrqHandler 0xdb
_irq_gate_fc: IrqHandler 0xdc
_irq_gate_fd: IrqHandler 0xdd
_irq_gate_fe: IrqHandler 0xde


_int_gate_irq_spurious:
    iretq

;------------------------------
;EOF
