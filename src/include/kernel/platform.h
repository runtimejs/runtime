// Copyright 2014 runtime.js project authors
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

#pragma once
#include <kernel/kernel.h>
#include <kernel/mem-manager.h>
#include <kernel/irq-dispatcher.h>
#include <kernel/system-context.h>
#include <kernel/profiler/profiler.h>

#include RT_INC_PLATFORM

namespace rt {

/**
 * Arch-independent platform
 */
class Platform {
public:
  Platform() : time_int_(0) {}

  /**
   * Start all other available CPUs
   */
  void StartCPUs() {
    platform_arch_.StartCPUs();
  }

  /**
   * Initialize per-cpu data
   */
  void InitCurrentCPU() {
    platform_arch_.InitCurrentCPU();
  }

  /**
   * Returns number of available CPUs in the system
   */
  uint32_t cpu_count() const {
    uint32_t cpus_count = platform_arch_.cpu_count();
    RT_ASSERT(cpus_count > 0);
    return cpus_count;
  }

  /**
   * Returns CPU bus frequency
   */
  uint32_t bus_frequency() const {
    return platform_arch_.bus_frequency();
  }

  /**
   * Returns IRQ dispatcher for current platform
   */
  IrqDispatcher& irq_dispatcher() {
    return irq_dispatcher_;
  }

  /**
   * Returns system profiler
   */
  Profiler& profiler() {
    return profiler_;
  }

  /**
   * IRQ handler (requires IRQ context)
   */
  void HandleIRQ(SystemContextIRQ irq_context, uint8_t number) {
    irq_dispatcher_.Raise(irq_context, number);
    platform_arch_.AckIRQ();
  }

  /**
   * Reboot this machine
   */
  void Reboot() {
    platform_arch_.Reboot();
    Cpu::HangSystem();
  }

  /**
   * Time since boot in microseconds
   */
  uint64_t BootTimeMicroseconds() const {
    return platform_arch_.BootTimeMicroseconds();
  }

  uint64_t RealTimeMicroseconds() const {
    return time_int_ + platform_arch_.BootTimeMicroseconds();
  }

  void SetTimeMicroseconds(uint64_t new_t) {
    time_int_ = new_t;
  }

  void SetCommandLine(std::string cmd) {
    command_line_ = cmd;
  }

  std::string GetCommandLine() const {
    return command_line_;
  }

  void EnterSleepState(uint32_t state) const;

  /**
   * Print current stack backtrace
   */
  void PrintBacktrace();
private:
  PlatformArch platform_arch_;
  IrqDispatcher irq_dispatcher_;
  Profiler profiler_;
  std::string command_line_;
  DELETE_COPY_AND_ASSIGN(Platform);
  uint64_t time_int_;
};

} // namespace rt
