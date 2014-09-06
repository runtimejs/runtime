// Copyright 2014 Runtime.JS project authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include <kernel/kernel.h>
#include <kernel/irqs.h>
#include <kernel/x64/io-x64.h>
#include <kernel/x64/irqs-x64.h>

extern "C" {
#define GATE(NAME) uint64_t NAME()
    GATE(int_gate_exception_DE);
    GATE(int_gate_exception_DB);
    GATE(int_gate_exception_NMI);
    GATE(int_gate_exception_BP);
    GATE(int_gate_exception_OF);
    GATE(int_gate_exception_BR);
    GATE(int_gate_exception_UD);
    GATE(int_gate_exception_NM);
    GATE(int_gate_exception_DF);
    GATE(int_gate_exception_TS);
    GATE(int_gate_exception_NP);
    GATE(int_gate_exception_SS);
    GATE(int_gate_exception_GP);
    GATE(int_gate_exception_PF);
    GATE(int_gate_exception_MF);
    GATE(int_gate_exception_AC);
    GATE(int_gate_exception_MC);
    GATE(int_gate_exception_XF);
    GATE(int_gate_exception_SX);
    GATE(int_gate_exception_other);
    GATE(int_gate_irq_timer);
    GATE(int_gate_irq_keyboard);
    GATE(int_gate_irq_other);
    GATE(int_gate_irq_spurious);
    GATE(gate_context_switch);
    GATE(_irq_gate_20);
    GATE(_irq_gate_21);
    GATE(_irq_gate_22);
    GATE(_irq_gate_23);
    GATE(_irq_gate_24);
    GATE(_irq_gate_25);
    GATE(_irq_gate_26);
    GATE(_irq_gate_27);
    GATE(_irq_gate_28);
    GATE(_irq_gate_29);
    GATE(_irq_gate_2a);
    GATE(_irq_gate_2b);
    GATE(_irq_gate_2c);
    GATE(_irq_gate_2d);
    GATE(_irq_gate_2e);
    GATE(_irq_gate_2f);
    GATE(_irq_gate_30);
    GATE(_irq_gate_31);
    GATE(_irq_gate_32);
    GATE(_irq_gate_33);
    GATE(_irq_gate_34);
    GATE(_irq_gate_35);
    GATE(_irq_gate_36);
    GATE(_irq_gate_37);
    GATE(_irq_gate_38);
    GATE(_irq_gate_39);
    GATE(_irq_gate_3a);
    GATE(_irq_gate_3b);
    GATE(_irq_gate_3c);
    GATE(_irq_gate_3d);
    GATE(_irq_gate_3e);
    GATE(_irq_gate_3f);
    GATE(_irq_gate_40);
    GATE(_irq_gate_41);
    GATE(_irq_gate_42);
    GATE(_irq_gate_43);
    GATE(_irq_gate_44);
    GATE(_irq_gate_45);
    GATE(_irq_gate_46);
    GATE(_irq_gate_47);
    GATE(_irq_gate_48);
    GATE(_irq_gate_49);
    GATE(_irq_gate_4a);
    GATE(_irq_gate_4b);
    GATE(_irq_gate_4c);
    GATE(_irq_gate_4d);
    GATE(_irq_gate_4e);
    GATE(_irq_gate_4f);
    GATE(_irq_gate_50);
    GATE(_irq_gate_51);
    GATE(_irq_gate_52);
    GATE(_irq_gate_53);
    GATE(_irq_gate_54);
    GATE(_irq_gate_55);
    GATE(_irq_gate_56);
    GATE(_irq_gate_57);
    GATE(_irq_gate_58);
    GATE(_irq_gate_59);
    GATE(_irq_gate_5a);
    GATE(_irq_gate_5b);
    GATE(_irq_gate_5c);
    GATE(_irq_gate_5d);
    GATE(_irq_gate_5e);
    GATE(_irq_gate_5f);
    GATE(_irq_gate_60);
    GATE(_irq_gate_61);
    GATE(_irq_gate_62);
    GATE(_irq_gate_63);
    GATE(_irq_gate_64);
    GATE(_irq_gate_65);
    GATE(_irq_gate_66);
    GATE(_irq_gate_67);
    GATE(_irq_gate_68);
    GATE(_irq_gate_69);
    GATE(_irq_gate_6a);
    GATE(_irq_gate_6b);
    GATE(_irq_gate_6c);
    GATE(_irq_gate_6d);
    GATE(_irq_gate_6e);
    GATE(_irq_gate_6f);
    GATE(_irq_gate_70);
    GATE(_irq_gate_71);
    GATE(_irq_gate_72);
    GATE(_irq_gate_73);
    GATE(_irq_gate_74);
    GATE(_irq_gate_75);
    GATE(_irq_gate_76);
    GATE(_irq_gate_77);
    GATE(_irq_gate_78);
    GATE(_irq_gate_79);
    GATE(_irq_gate_7a);
    GATE(_irq_gate_7b);
    GATE(_irq_gate_7c);
    GATE(_irq_gate_7d);
    GATE(_irq_gate_7e);
    GATE(_irq_gate_7f);
    GATE(_irq_gate_80);
    GATE(_irq_gate_81);
    GATE(_irq_gate_82);
    GATE(_irq_gate_83);
    GATE(_irq_gate_84);
    GATE(_irq_gate_85);
    GATE(_irq_gate_86);
    GATE(_irq_gate_87);
    GATE(_irq_gate_88);
    GATE(_irq_gate_89);
    GATE(_irq_gate_8a);
    GATE(_irq_gate_8b);
    GATE(_irq_gate_8c);
    GATE(_irq_gate_8d);
    GATE(_irq_gate_8e);
    GATE(_irq_gate_8f);
    GATE(_irq_gate_90);
    GATE(_irq_gate_91);
    GATE(_irq_gate_92);
    GATE(_irq_gate_93);
    GATE(_irq_gate_94);
    GATE(_irq_gate_95);
    GATE(_irq_gate_96);
    GATE(_irq_gate_97);
    GATE(_irq_gate_98);
    GATE(_irq_gate_99);
    GATE(_irq_gate_9a);
    GATE(_irq_gate_9b);
    GATE(_irq_gate_9c);
    GATE(_irq_gate_9d);
    GATE(_irq_gate_9e);
    GATE(_irq_gate_9f);
    GATE(_irq_gate_a0);
    GATE(_irq_gate_a1);
    GATE(_irq_gate_a2);
    GATE(_irq_gate_a3);
    GATE(_irq_gate_a4);
    GATE(_irq_gate_a5);
    GATE(_irq_gate_a6);
    GATE(_irq_gate_a7);
    GATE(_irq_gate_a8);
    GATE(_irq_gate_a9);
    GATE(_irq_gate_aa);
    GATE(_irq_gate_ab);
    GATE(_irq_gate_ac);
    GATE(_irq_gate_ad);
    GATE(_irq_gate_ae);
    GATE(_irq_gate_af);
    GATE(_irq_gate_b0);
    GATE(_irq_gate_b1);
    GATE(_irq_gate_b2);
    GATE(_irq_gate_b3);
    GATE(_irq_gate_b4);
    GATE(_irq_gate_b5);
    GATE(_irq_gate_b6);
    GATE(_irq_gate_b7);
    GATE(_irq_gate_b8);
    GATE(_irq_gate_b9);
    GATE(_irq_gate_ba);
    GATE(_irq_gate_bb);
    GATE(_irq_gate_bc);
    GATE(_irq_gate_bd);
    GATE(_irq_gate_be);
    GATE(_irq_gate_bf);
    GATE(_irq_gate_c0);
    GATE(_irq_gate_c1);
    GATE(_irq_gate_c2);
    GATE(_irq_gate_c3);
    GATE(_irq_gate_c4);
    GATE(_irq_gate_c5);
    GATE(_irq_gate_c6);
    GATE(_irq_gate_c7);
    GATE(_irq_gate_c8);
    GATE(_irq_gate_c9);
    GATE(_irq_gate_ca);
    GATE(_irq_gate_cb);
    GATE(_irq_gate_cc);
    GATE(_irq_gate_cd);
    GATE(_irq_gate_ce);
    GATE(_irq_gate_cf);
    GATE(_irq_gate_d0);
    GATE(_irq_gate_d1);
    GATE(_irq_gate_d2);
    GATE(_irq_gate_d3);
    GATE(_irq_gate_d4);
    GATE(_irq_gate_d5);
    GATE(_irq_gate_d6);
    GATE(_irq_gate_d7);
    GATE(_irq_gate_d8);
    GATE(_irq_gate_d9);
    GATE(_irq_gate_da);
    GATE(_irq_gate_db);
    GATE(_irq_gate_dc);
    GATE(_irq_gate_dd);
    GATE(_irq_gate_de);
    GATE(_irq_gate_df);
    GATE(_irq_gate_e0);
    GATE(_irq_gate_e1);
    GATE(_irq_gate_e2);
    GATE(_irq_gate_e3);
    GATE(_irq_gate_e4);
    GATE(_irq_gate_e5);
    GATE(_irq_gate_e6);
    GATE(_irq_gate_e7);
    GATE(_irq_gate_e8);
    GATE(_irq_gate_e9);
    GATE(_irq_gate_ea);
    GATE(_irq_gate_eb);
    GATE(_irq_gate_ec);
    GATE(_irq_gate_ed);
    GATE(_irq_gate_ee);
    GATE(_irq_gate_ef);
    GATE(_irq_gate_f0);
    GATE(_irq_gate_f1);
    GATE(_irq_gate_f2);
    GATE(_irq_gate_f3);
    GATE(_irq_gate_f4);
    GATE(_irq_gate_f5);
    GATE(_irq_gate_f6);
    GATE(_irq_gate_f7);
    GATE(_irq_gate_f8);
    GATE(_irq_gate_f9);
    GATE(_irq_gate_fa);
    GATE(_irq_gate_fb);
    GATE(_irq_gate_fc);
    GATE(_irq_gate_fd);
    GATE(_irq_gate_fe);
#undef GATE
} // extern "C"

namespace rt {

void IrqsArch::DisableNMI() {
    IoPortsX64::OutB(0x70, IoPortsX64::InB(0x70) | 0x80);
}

void IrqsArch::EnableNMI() {
    IoPortsX64::OutB(0x70, IoPortsX64::InB(0x70) & 0x7F);
}

void IrqsArch::InstallGate(uint8_t vector, uint64_t (*func)(), uint8_t type) {
    uint8_t* idt_table = (uint8_t*)kIDTTableBase;
    uint8_t b[16];

    b[0] = (uint64_t)func & 0x00000000000000FF;
    b[1] = ((uint64_t)func & 0x000000000000FF00) >> 8;
    b[2] = kCodeSelector;
    b[3] = 0;
    b[4] = 0;
    b[5] = type;
    b[6] = ((uint64_t)func & 0x0000000000FF0000) >> 16;
    b[7] = ((uint64_t)func & 0x00000000FF000000) >> 24;

    b[8] = ((uint64_t)func & 0x000000FF00000000) >> 32;
    b[9] = ((uint64_t)func & 0x0000FF0000000000) >> 40;
    b[10] = ((uint64_t)func & 0x00FF000000000000) >> 48;
    b[11] = ((uint64_t)func & 0xFF00000000000000) >> 56;
    b[12] = 0;
    b[13] = 0;
    b[14] = 0;
    b[15] = 0;

    for (uint32_t i = 0; i < 16; ++i) {
        *(idt_table + vector * 16 + i) = b[i];
    }
}

void IrqsArch::SetUp() {
    DisableNMI();

    // Remap IRQs
    IoPortsX64::OutB(0x20, 0x11); // 00010001b, begin PIC 1 initialization
    IoPortsX64::OutB(0xA0, 0x11); // 00010001b, begin PIC 2 initialization

    IoPortsX64::OutB(0x21, 0x20); // IRQ 0-7, interrupts 20h-27h
    IoPortsX64::OutB(0xA1, 0x28); // IRQ 8-15, interrupts 28h-2Fh

    IoPortsX64::OutB(0x21, 0x04);
    IoPortsX64::OutB(0xA1, 0x02);

    IoPortsX64::OutB(0x21, 0x01);
    IoPortsX64::OutB(0xA1, 0x01);

    // Mask all PIC interrupts
    IoPortsX64::OutB(0x21, 0xFF);
    IoPortsX64::OutB(0xA1, 0xFF);

    // Gate type
    uint8_t type = 0x8e;

    // Exceptions (0-31)
    InstallGate(0x00, &int_gate_exception_DE, type);
    InstallGate(0x01, &int_gate_exception_DB, type);
    InstallGate(0x02, &int_gate_exception_NMI,type);
    InstallGate(0x03, &int_gate_exception_BP, type);
    InstallGate(0x04, &int_gate_exception_OF, type);
    InstallGate(0x05, &int_gate_exception_BR, type);
    InstallGate(0x06, &int_gate_exception_UD, type);
    InstallGate(0x07, &int_gate_exception_NM, type);
    InstallGate(0x08, &int_gate_exception_DF, type);
    InstallGate(0x09, &int_gate_exception_other, type);
    InstallGate(0x0A, &int_gate_exception_TS, type);
    InstallGate(0x0B, &int_gate_exception_NP, type);
    InstallGate(0x0C, &int_gate_exception_SS, type);
    InstallGate(0x0D, &int_gate_exception_GP, type);
    InstallGate(0x0E, &int_gate_exception_PF, type);
    InstallGate(0x0F, &int_gate_exception_other, type);
    InstallGate(0x10, &int_gate_exception_MF, type);
    InstallGate(0x11, &int_gate_exception_AC, type);
    InstallGate(0x12, &int_gate_exception_MC, type);
    InstallGate(0x13, &int_gate_exception_XF, type);
    InstallGate(0x14, &int_gate_exception_other, type);
    InstallGate(0x15, &int_gate_exception_other, type);
    InstallGate(0x16, &int_gate_exception_other, type);
    InstallGate(0x17, &int_gate_exception_other, type);
    InstallGate(0x18, &int_gate_exception_other, type);
    InstallGate(0x19, &int_gate_exception_other, type);
    InstallGate(0x1A, &int_gate_exception_other, type);
    InstallGate(0x1B, &int_gate_exception_other, type);
    InstallGate(0x1C, &int_gate_exception_other, type);
    InstallGate(0x1D, &int_gate_exception_other, type);
    InstallGate(0x1E, &int_gate_exception_SX, type);
    InstallGate(0x1F, &int_gate_exception_other, type);

    // Special
    InstallGate(0x20, &int_gate_irq_timer, type);

    // Other
    InstallGate(0x21, &_irq_gate_21, type);
    InstallGate(0x22, &int_gate_irq_timer, type);
    InstallGate(0x23, &_irq_gate_23, type);
    InstallGate(0x24, &_irq_gate_24, type);
    InstallGate(0x25, &_irq_gate_25, type);
    InstallGate(0x26, &_irq_gate_26, type);
    InstallGate(0x27, &_irq_gate_27, type);
    InstallGate(0x28, &_irq_gate_28, type);
    InstallGate(0x29, &_irq_gate_29, type);
    InstallGate(0x2a, &_irq_gate_2a, type);
    InstallGate(0x2b, &_irq_gate_2b, type);
    InstallGate(0x2c, &_irq_gate_2c, type);
    InstallGate(0x2d, &_irq_gate_2d, type);
    InstallGate(0x2e, &_irq_gate_2e, type);
    InstallGate(0x2f, &_irq_gate_2f, type);
    InstallGate(0x30, &_irq_gate_30, type);
    InstallGate(0x31, &_irq_gate_31, type);
    InstallGate(0x32, &_irq_gate_32, type);
    InstallGate(0x33, &_irq_gate_33, type);
    InstallGate(0x34, &_irq_gate_34, type);
    InstallGate(0x35, &_irq_gate_35, type);
    InstallGate(0x36, &_irq_gate_36, type);
    InstallGate(0x37, &_irq_gate_37, type);
    InstallGate(0x38, &_irq_gate_38, type);
    InstallGate(0x39, &_irq_gate_39, type);
    InstallGate(0x3a, &_irq_gate_3a, type);
    InstallGate(0x3b, &_irq_gate_3b, type);
    InstallGate(0x3c, &_irq_gate_3c, type);
    InstallGate(0x3d, &_irq_gate_3d, type);
    InstallGate(0x3e, &_irq_gate_3e, type);
    InstallGate(0x3f, &_irq_gate_3f, type);
    InstallGate(0x40, &_irq_gate_40, type);
    InstallGate(0x41, &_irq_gate_41, type);
    InstallGate(0x42, &_irq_gate_42, type);
    InstallGate(0x43, &_irq_gate_43, type);
    InstallGate(0x44, &_irq_gate_44, type);
    InstallGate(0x45, &_irq_gate_45, type);
    InstallGate(0x46, &_irq_gate_46, type);
    InstallGate(0x47, &_irq_gate_47, type);
    InstallGate(0x48, &_irq_gate_48, type);
    InstallGate(0x49, &_irq_gate_49, type);
    InstallGate(0x4a, &_irq_gate_4a, type);
    InstallGate(0x4b, &_irq_gate_4b, type);
    InstallGate(0x4c, &_irq_gate_4c, type);
    InstallGate(0x4d, &_irq_gate_4d, type);
    InstallGate(0x4e, &_irq_gate_4e, type);
    InstallGate(0x4f, &_irq_gate_4f, type);
    InstallGate(0x50, &_irq_gate_50, type);
    InstallGate(0x51, &_irq_gate_51, type);
    InstallGate(0x52, &_irq_gate_52, type);
    InstallGate(0x53, &_irq_gate_53, type);
    InstallGate(0x54, &_irq_gate_54, type);
    InstallGate(0x55, &_irq_gate_55, type);
    InstallGate(0x56, &_irq_gate_56, type);
    InstallGate(0x57, &_irq_gate_57, type);
    InstallGate(0x58, &_irq_gate_58, type);
    InstallGate(0x59, &_irq_gate_59, type);
    InstallGate(0x5a, &_irq_gate_5a, type);
    InstallGate(0x5b, &_irq_gate_5b, type);
    InstallGate(0x5c, &_irq_gate_5c, type);
    InstallGate(0x5d, &_irq_gate_5d, type);
    InstallGate(0x5e, &_irq_gate_5e, type);
    InstallGate(0x5f, &_irq_gate_5f, type);
    InstallGate(0x60, &_irq_gate_60, type);
    InstallGate(0x61, &_irq_gate_61, type);
    InstallGate(0x62, &_irq_gate_62, type);
    InstallGate(0x63, &_irq_gate_63, type);
    InstallGate(0x64, &_irq_gate_64, type);
    InstallGate(0x65, &_irq_gate_65, type);
    InstallGate(0x66, &_irq_gate_66, type);
    InstallGate(0x67, &_irq_gate_67, type);
    InstallGate(0x68, &_irq_gate_68, type);
    InstallGate(0x69, &_irq_gate_69, type);
    InstallGate(0x6a, &_irq_gate_6a, type);
    InstallGate(0x6b, &_irq_gate_6b, type);
    InstallGate(0x6c, &_irq_gate_6c, type);
    InstallGate(0x6d, &_irq_gate_6d, type);
    InstallGate(0x6e, &_irq_gate_6e, type);
    InstallGate(0x6f, &_irq_gate_6f, type);
    InstallGate(0x70, &_irq_gate_70, type);
    InstallGate(0x71, &_irq_gate_71, type);
    InstallGate(0x72, &_irq_gate_72, type);
    InstallGate(0x73, &_irq_gate_73, type);
    InstallGate(0x74, &_irq_gate_74, type);
    InstallGate(0x75, &_irq_gate_75, type);
    InstallGate(0x76, &_irq_gate_76, type);
    InstallGate(0x77, &_irq_gate_77, type);
    InstallGate(0x78, &_irq_gate_78, type);
    InstallGate(0x79, &_irq_gate_79, type);
    InstallGate(0x7a, &_irq_gate_7a, type);
    InstallGate(0x7b, &_irq_gate_7b, type);
    InstallGate(0x7c, &_irq_gate_7c, type);
    InstallGate(0x7d, &_irq_gate_7d, type);
    InstallGate(0x7e, &_irq_gate_7e, type);
    InstallGate(0x7f, &_irq_gate_7f, type);
    InstallGate(0x80, &_irq_gate_80, type);
    InstallGate(0x81, &_irq_gate_81, type);
    InstallGate(0x82, &_irq_gate_82, type);
    InstallGate(0x83, &_irq_gate_83, type);
    InstallGate(0x84, &_irq_gate_84, type);
    InstallGate(0x85, &_irq_gate_85, type);
    InstallGate(0x86, &_irq_gate_86, type);
    InstallGate(0x87, &_irq_gate_87, type);
    InstallGate(0x88, &_irq_gate_88, type);
    InstallGate(0x89, &_irq_gate_89, type);
    InstallGate(0x8a, &_irq_gate_8a, type);
    InstallGate(0x8b, &_irq_gate_8b, type);
    InstallGate(0x8c, &_irq_gate_8c, type);
    InstallGate(0x8d, &_irq_gate_8d, type);
    InstallGate(0x8e, &_irq_gate_8e, type);
    InstallGate(0x8f, &_irq_gate_8f, type);
    InstallGate(0x90, &_irq_gate_90, type);
    InstallGate(0x91, &_irq_gate_91, type);
    InstallGate(0x92, &_irq_gate_92, type);
    InstallGate(0x93, &_irq_gate_93, type);
    InstallGate(0x94, &_irq_gate_94, type);
    InstallGate(0x95, &_irq_gate_95, type);
    InstallGate(0x96, &_irq_gate_96, type);
    InstallGate(0x97, &_irq_gate_97, type);
    InstallGate(0x98, &_irq_gate_98, type);
    InstallGate(0x99, &_irq_gate_99, type);
    InstallGate(0x9a, &_irq_gate_9a, type);
    InstallGate(0x9b, &_irq_gate_9b, type);
    InstallGate(0x9c, &_irq_gate_9c, type);
    InstallGate(0x9d, &_irq_gate_9d, type);
    InstallGate(0x9e, &_irq_gate_9e, type);
    InstallGate(0x9f, &_irq_gate_9f, type);
    InstallGate(0xa0, &_irq_gate_a0, type);
    InstallGate(0xa1, &_irq_gate_a1, type);
    InstallGate(0xa2, &_irq_gate_a2, type);
    InstallGate(0xa3, &_irq_gate_a3, type);
    InstallGate(0xa4, &_irq_gate_a4, type);
    InstallGate(0xa5, &_irq_gate_a5, type);
    InstallGate(0xa6, &_irq_gate_a6, type);
    InstallGate(0xa7, &_irq_gate_a7, type);
    InstallGate(0xa8, &_irq_gate_a8, type);
    InstallGate(0xa9, &_irq_gate_a9, type);
    InstallGate(0xaa, &_irq_gate_aa, type);
    InstallGate(0xab, &_irq_gate_ab, type);
    InstallGate(0xac, &_irq_gate_ac, type);
    InstallGate(0xad, &_irq_gate_ad, type);
    InstallGate(0xae, &_irq_gate_ae, type);
    InstallGate(0xaf, &_irq_gate_af, type);
    InstallGate(0xb0, &_irq_gate_b0, type);
    InstallGate(0xb1, &_irq_gate_b1, type);
    InstallGate(0xb2, &_irq_gate_b2, type);
    InstallGate(0xb3, &_irq_gate_b3, type);
    InstallGate(0xb4, &_irq_gate_b4, type);
    InstallGate(0xb5, &_irq_gate_b5, type);
    InstallGate(0xb6, &_irq_gate_b6, type);
    InstallGate(0xb7, &_irq_gate_b7, type);
    InstallGate(0xb8, &_irq_gate_b8, type);
    InstallGate(0xb9, &_irq_gate_b9, type);
    InstallGate(0xba, &_irq_gate_ba, type);
    InstallGate(0xbb, &_irq_gate_bb, type);
    InstallGate(0xbc, &_irq_gate_bc, type);
    InstallGate(0xbd, &_irq_gate_bd, type);
    InstallGate(0xbe, &_irq_gate_be, type);
    InstallGate(0xbf, &_irq_gate_bf, type);
    InstallGate(0xc0, &_irq_gate_c0, type);
    InstallGate(0xc1, &_irq_gate_c1, type);
    InstallGate(0xc2, &_irq_gate_c2, type);
    InstallGate(0xc3, &_irq_gate_c3, type);
    InstallGate(0xc4, &_irq_gate_c4, type);
    InstallGate(0xc5, &_irq_gate_c5, type);
    InstallGate(0xc6, &_irq_gate_c6, type);
    InstallGate(0xc7, &_irq_gate_c7, type);
    InstallGate(0xc8, &_irq_gate_c8, type);
    InstallGate(0xc9, &_irq_gate_c9, type);
    InstallGate(0xca, &_irq_gate_ca, type);
    InstallGate(0xcb, &_irq_gate_cb, type);
    InstallGate(0xcc, &_irq_gate_cc, type);
    InstallGate(0xcd, &_irq_gate_cd, type);
    InstallGate(0xce, &_irq_gate_ce, type);
    InstallGate(0xcf, &_irq_gate_cf, type);
    InstallGate(0xd0, &_irq_gate_d0, type);
    InstallGate(0xd1, &_irq_gate_d1, type);
    InstallGate(0xd2, &_irq_gate_d2, type);
    InstallGate(0xd3, &_irq_gate_d3, type);
    InstallGate(0xd4, &_irq_gate_d4, type);
    InstallGate(0xd5, &_irq_gate_d5, type);
    InstallGate(0xd6, &_irq_gate_d6, type);
    InstallGate(0xd7, &_irq_gate_d7, type);
    InstallGate(0xd8, &_irq_gate_d8, type);
    InstallGate(0xd9, &_irq_gate_d9, type);
    InstallGate(0xda, &_irq_gate_da, type);
    InstallGate(0xdb, &_irq_gate_db, type);
    InstallGate(0xdc, &_irq_gate_dc, type);
    InstallGate(0xdd, &_irq_gate_dd, type);
    InstallGate(0xde, &_irq_gate_de, type);
    InstallGate(0xdf, &_irq_gate_df, type);
    InstallGate(0xe0, &_irq_gate_e0, type);
    InstallGate(0xe1, &_irq_gate_e1, type);
    InstallGate(0xe2, &_irq_gate_e2, type);
    InstallGate(0xe3, &_irq_gate_e3, type);
    InstallGate(0xe4, &_irq_gate_e4, type);
    InstallGate(0xe5, &_irq_gate_e5, type);
    InstallGate(0xe6, &_irq_gate_e6, type);
    InstallGate(0xe7, &_irq_gate_e7, type);
    InstallGate(0xe8, &_irq_gate_e8, type);
    InstallGate(0xe9, &_irq_gate_e9, type);
    InstallGate(0xea, &_irq_gate_ea, type);
    InstallGate(0xeb, &_irq_gate_eb, type);
    InstallGate(0xec, &_irq_gate_ec, type);
    InstallGate(0xed, &_irq_gate_ed, type);
    InstallGate(0xee, &_irq_gate_ee, type);
    InstallGate(0xef, &_irq_gate_ef, type);
    InstallGate(0xf0, &_irq_gate_f0, type);
    InstallGate(0xf1, &_irq_gate_f1, type);
    InstallGate(0xf2, &_irq_gate_f2, type);
    InstallGate(0xf3, &_irq_gate_f3, type);
    InstallGate(0xf4, &_irq_gate_f4, type);
    InstallGate(0xf5, &_irq_gate_f5, type);
    InstallGate(0xf6, &_irq_gate_f6, type);
    InstallGate(0xf7, &_irq_gate_f7, type);
    InstallGate(0xf8, &_irq_gate_f8, type);
    InstallGate(0xf9, &_irq_gate_f9, type);
    InstallGate(0xfa, &_irq_gate_fa, type);
    InstallGate(0xfb, &_irq_gate_fb, type);
    InstallGate(0xfc, &_irq_gate_fc, type);
    InstallGate(0xfd, &_irq_gate_fd, type);
    InstallGate(0xfe, &_irq_gate_fe, type);

    // Spurious
    InstallGate(0xff, &int_gate_irq_spurious, type);
}

} // namespace rt
