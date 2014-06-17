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

#include <kernel/kernel-main.h>

#include <libc.h>
#include <stdio.h>

#include <kernel/keystorage.h>
#include <kernel/initrd.h>
#include <kernel/engines.h>
#include <kernel/trace.h>
#include <kernel/kernel.h>
#include <kernel/multiboot.h>
#include <kernel/version.h>
#include <kernel/boot-services.h>
#include <kernel/logger.h>
#include <kernel/platform.h>
#include <kernel/irqs.h>

#include <test-framework.h>

#define DEFINE_GLOBAL_OBJECT(name, type)                       \
    static uint8_t placement_##name[sizeof(type)] alignas(16); \
    type* intr_##name = nullptr

DEFINE_GLOBAL_OBJECT(GLOBAL_platform, rt::Platform);
DEFINE_GLOBAL_OBJECT(GLOBAL_boot_services, rt::BootServices);
DEFINE_GLOBAL_OBJECT(GLOBAL_multiboot, rt::Multiboot);
DEFINE_GLOBAL_OBJECT(GLOBAL_mem_manager, rt::MemManager);
DEFINE_GLOBAL_OBJECT(GLOBAL_irqs, rt::Irqs);
DEFINE_GLOBAL_OBJECT(GLOBAL_keystorage, rt::KeyStorage);
DEFINE_GLOBAL_OBJECT(GLOBAL_initrd, rt::Initrd);
DEFINE_GLOBAL_OBJECT(GLOBAL_engines, rt::Engines);
DEFINE_GLOBAL_OBJECT(GLOBAL_trace, rt::Trace);

#undef DEFINE_GLOBAL_OBJECT

#define CONSTRUCT_GLOBAL_OBJECT(name, type, param)              \
    memset(&placement_##name, 0, sizeof(placement_##name));     \
    intr_##name = new (&placement_##name) type(param);          \
    RT_ASSERT(reinterpret_cast<void*>(&placement_##name)        \
            == reinterpret_cast<void*>(name()));                \
    RT_ASSERT(intr_##name)

typedef void (*function_pointer) (void);
extern function_pointer start_ctors[];
extern function_pointer end_ctors[];

int mksnapshot_main(int argc, char** argv);

namespace rt {

void KernelMain::Initialize(void* mbt) {
    CONSTRUCT_GLOBAL_OBJECT(GLOBAL_boot_services, BootServices, );      // NOLINT
    CONSTRUCT_GLOBAL_OBJECT(GLOBAL_multiboot, Multiboot, mbt);			// NOLINT
    CONSTRUCT_GLOBAL_OBJECT(GLOBAL_mem_manager, MemManager, );          // NOLINT

    Cpu::DisableInterrupts();
    CONSTRUCT_GLOBAL_OBJECT(GLOBAL_irqs, Irqs, );  					    // NOLINT

    // Initialize memory manager for this CPU
    // After this line we can use malloc / free to allocate memory
    GLOBAL_mem_manager()->InitSubsystems();

    CONSTRUCT_GLOBAL_OBJECT(GLOBAL_keystorage, KeyStorage, );           // NOLINT
    CONSTRUCT_GLOBAL_OBJECT(GLOBAL_initrd, Initrd, );                   // NOLINT
    CONSTRUCT_GLOBAL_OBJECT(GLOBAL_trace, Trace, );                     // NOLINT

    // This will run V8 static constructors
    uint64_t ctor_count = (end_ctors - start_ctors);
    for (uint64_t x = 0; x < ctor_count; x++) {
        function_pointer constructor = start_ctors[x];
        constructor();
    }
}

MultibootParseResult KernelMain::ParseMultiboot(void* mbt) {
    MultibootStruct* s = reinterpret_cast<MultibootStruct*>(mbt);
    RT_ASSERT(s);
    uint32_t mod_count = s->module_count;
    uint32_t mod_addr = s->module_addr;

    if (0 == mod_count || 0 == mod_addr) {
        printf("Initrd boot module required. Check your bootloader configuration.\n");
        abort();
    }

    const char* cmd = nullptr;
    uint32_t cmdaddr = s->cmdline;
    if (0 != cmdaddr) {
        cmd = reinterpret_cast<const char*>(cmdaddr);
    } else {
        cmd = "";
    }

    RT_ASSERT(cmd);

    MultibootModuleEntry* m = reinterpret_cast<MultibootModuleEntry*>(mod_addr);
    RT_ASSERT(m);
    uint32_t rd_start = m->start;
    uint32_t rd_end = m->end;

    // This might be useful if initrd is unable to load files
    // rd_start = mod_addr;

    size_t len = rd_end - rd_start;

    if (0 == len || len  > 128 * common::Constants::MiB) {
        printf("Invalid initrd boot module.\n");
        abort();
    }

    GLOBAL_initrd()->Init(reinterpret_cast<void*>(rd_start), len);
    return MultibootParseResult(cmd);
}


void KernelMain::MakeV8Snapshot() {
    char** argv = new char*[2];
    argv[0] = new char[16];
    argv[1] = new char[16];
    strcpy(argv[0], "mksnapshot");
    strcpy(argv[1], "snapshot");
    mksnapshot_main(2, argv);
}

void KernelMain::InitSystemBSP(void* mbt) {
    // some musl libc init
    libc.threads_minus_1 = 0;

    Initialize(mbt);
    MultibootParseResult parsed = ParseMultiboot(mbt);
    CONSTRUCT_GLOBAL_OBJECT(GLOBAL_platform, Platform, );		        // NOLINT

    uint32_t cpus_found = GLOBAL_platform()->cpu_count();
    GLOBAL_platform()->InitCurrentCPU();

    printf("Found %d cpus.\n", cpus_found);

    const char* cmdline = parsed.cmdline();
    if (nullptr != strstr(cmdline, "test")) {
        GLOBAL_boot_services()->logger()->SetMode(LoggerMode::TEST);
        test::TestFramework tests;
        tests.RunTests();
        Cpu::HangSystem();
    }

    if (nullptr != strstr(cmdline, "snapshot")) {
        printf("Generating snapshot...\n");
        GLOBAL_boot_services()->logger()->SetMode(LoggerMode::SNAPSHOT);
        MakeV8Snapshot();
        GLOBAL_boot_services()->logger()->SetMode(LoggerMode::VIDEO);
        printf("Snapshot done.\n\nNow you can shutdown the system.\n");
        Cpu::HangSystem();
    }

    GLOBAL_boot_services()->logger()->EnableConsole();
    CONSTRUCT_GLOBAL_OBJECT(GLOBAL_engines, Engines, cpus_found);
    Cpu::EnableInterrupts();
    GLOBAL_engines()->Startup();
    GLOBAL_platform()->StartCPUs();
}

void KernelMain::InitSystemAP() {
    GLOBAL_mem_manager()->InitSubsystems();
    GLOBAL_platform()->InitCurrentCPU();
}

KernelMain::KernelMain(void* mbt) {
    uint32_t cpuid = Cpu::id();

    if (cpuid != 0) {
        InitSystemAP();
    } else {
        InitSystemBSP(mbt);
    }

    GLOBAL_engines()->CpuEnter();
}

} // namespace rt
