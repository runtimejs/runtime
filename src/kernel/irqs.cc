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
#include <kernel/cpu.h>
#include <kernel/mem-manager.h>
#include <kernel/platform.h>
#include <kernel/engines.h>
#include <kernel/profiler/profiler.h>

using namespace rt;

#define EXPORT_EVENT extern "C"

EXPORT_EVENT void exception_DE_event() {
    RT_ASSERT(!"!Ex_x86_64_DE");
    Cpu::HangSystem();
}

EXPORT_EVENT void exception_DB_event() {
    RT_ASSERT(!"!Ex_x86_64_DB");
    Cpu::HangSystem();
}

EXPORT_EVENT void exception_NMI_event() {
    RT_ASSERT(!"!Ex_x86_64_NMI");
    Cpu::HangSystem();
}

EXPORT_EVENT void exception_BP_event() {
    RT_ASSERT(!"!Ex_x86_64_BP");
    Cpu::HangSystem();
}

EXPORT_EVENT void exception_OF_event() {
    RT_ASSERT(!"!Ex_x86_64_OF");
    Cpu::HangSystem();
}

EXPORT_EVENT void exception_BR_event() {
    RT_ASSERT(!"!Ex_x86_64_BR");
    Cpu::HangSystem();
}

EXPORT_EVENT void exception_UD_event(uint64_t rip, uint64_t cs) {
    printf(" >>>> RIP = 0x%x, CS = 0x%x, CPU = %d\n", rip, cs, rt::Cpu::id());
    RT_ASSERT(!"!Ex_x86_64_UD");
    Cpu::HangSystem();
}

EXPORT_EVENT void exception_NM_event() {
    RT_ASSERT(!"!Ex_x86_64_NM");
    Cpu::HangSystem();
}

EXPORT_EVENT void exception_DF_event() {
    RT_ASSERT(!"!Ex_x86_64_DF");
    Cpu::HangSystem();
}

EXPORT_EVENT void exception_TS_event() {
    RT_ASSERT(!"!Ex_x86_64_TS");
    Cpu::HangSystem();
}

EXPORT_EVENT void exception_NP_event() {
    RT_ASSERT(!"!Ex_x86_64_NP");
    Cpu::HangSystem();
}

EXPORT_EVENT void exception_SS_event() {
    RT_ASSERT(!"!Ex_x86_64_SS");
    Cpu::HangSystem();
}

EXPORT_EVENT void exception_GP_event(uint64_t rip, uint64_t cs, uint64_t errcode, uint64_t p1) {
    printf("[GP+] >>>> RIP = 0x%x, CS = 0x%x, ERRCODE = %d, RAX = 0x%x CPU = %d\n",
           rip, cs, errcode, p1, rt::Cpu::id());
}

EXPORT_EVENT void exception_PF_event(void* fault_address, uint64_t error_code) {
    GLOBAL_mem_manager()->PageFault(fault_address, error_code);
}

EXPORT_EVENT void exception_MF_event() {
    RT_ASSERT(!"!Ex_x86_64_MF");
    Cpu::HangSystem();
}

EXPORT_EVENT void exception_AC_event() {
    RT_ASSERT(!"!Ex_x86_64_AC");
    Cpu::HangSystem();
}

EXPORT_EVENT void exception_MC_event() {
    RT_ASSERT(!"!Ex_x86_64_MC");
    Cpu::HangSystem();
}

EXPORT_EVENT void exception_XF_event() {
    RT_ASSERT(!"!Ex_x86_64_XF");
    Cpu::HangSystem();
}

EXPORT_EVENT void exception_SX_event() {
    RT_ASSERT(!"!Ex_x86_64_SX");
    Cpu::HangSystem();
}

EXPORT_EVENT void exception_other_event() {
    RT_ASSERT(!"!Ex_OTHER");
    Cpu::HangSystem();
}

EXPORT_EVENT void irq_keyboard_event(uint64_t* rip) {
    SystemContextDefaultIRQ irq_context {};
    printf("KBD!\n");
    RT_ASSERT(GLOBAL_platform());

    // TODO: remove this handler
    GLOBAL_platform()->HandleIRQ(irq_context, 1);
}

int net_irq_count = 0;

EXPORT_EVENT void irq_handler_any(uint64_t number) {
    SystemContextDefaultIRQ irq_context {};

    if (1 != number) {
        // Log all IRQ except keyboard
//        printf("IRQ %d, cpu %d\n", number, rt::Cpu::id());
    }

    RT_ASSERT(number <= 0xff);
    RT_ASSERT(GLOBAL_platform());
    GLOBAL_platform()->HandleIRQ(irq_context, number & 0xff);
}

// TODO: fix this event
EXPORT_EVENT void irq_timer_event(void* rsp, void* rbp, void* rip) {
    rt::SystemContextTimerIRQ irq_context {};
    RT_ASSERT(GLOBAL_engines());
    GLOBAL_engines()->TimerTick(irq_context);

    RegisterState state;
    state.rsp = rsp;
    state.rbp = rbp;
    state.rip = rip;
    GLOBAL_platform()->profiler().MakeSample(irq_context, state);

    // TODO: fix hardcoded apic base address
    LocalApicRegisterAccessor registers((void*)0xfee00000);
    registers.Write(LocalApicRegister::EOI, 0);
}

EXPORT_EVENT void irq_other_event() {
    RT_ASSERT(!"!INT.OTHER");
    Cpu::HangSystem();
}

EXPORT_EVENT void gate_context_switch_event() {
    RT_ASSERT(!"!GT");
    Cpu::HangSystem();
}

#undef EXPORT_EVENT
