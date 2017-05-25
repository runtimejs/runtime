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

#include <vector>
#include <atomic>
#include <kernel/kernel.h>
#include <kernel/cpu.h>
#include <kernel/resource.h>
#include <kernel/engine.h>
#include <kernel/system-context.h>
#include <kernel/initrd.h>
#include <kernel/v8platform.h>
#include <string>
#include <string.h>
#include <json11.hpp>

namespace rt {

class AcpiManager;
bool EntropySource(unsigned char* buffer, size_t length);

class Engines {
public:
  Engines(uint32_t cpu_count)
    :   cpu_count_(cpu_count),
        buffers_size_(0),
        buffers_count_(0),
        _non_isolate_ticks(0),
        v8_platform_(nullptr) {
    RT_ASSERT(nullptr == GLOBAL_engines());
    RT_ASSERT(this);
    RT_ASSERT(cpu_count >= 1);

    global_ticks_counter_ = 1;

    engines_.reserve(cpu_count);
    engines_execution_.reserve(cpu_count);

    for (uint32_t i = 0; i < cpu_count; ++i) {
      Engine* engine = nullptr;
      if (9999 == i) {
        engine = new Engine(EngineType::SERVICE);
      } else {
        engine = new Engine(EngineType::EXECUTION);
        engines_execution_.push_back(engine);
        engine->threads().Create(ThreadType::IDLE); // create idle thread
      }
      RT_ASSERT(engine);
      engines_.push_back(engine);
    }

    RT_ASSERT(engines_.size() > 0);
    RT_ASSERT(engines_execution_.size() > 0);

    v8::V8::InitializeICU();
    RT_ASSERT(!v8_platform_);
    v8_platform_ = new V8Platform();
    RT_ASSERT(v8_platform_);

    v8::V8::SetEntropySource(EntropySource);

    InitrdFile runtime_json = GLOBAL_initrd()->Get("/runtime.json");
    if (!runtime_json.IsEmpty()) {
      const char* runtime_json_cont = (const char*)runtime_json.Data();

      std::string err;
      json11::Json root = json11::Json::parse(runtime_json_cont, err);
      if (err.empty()) {
        json11::Json v8 = root["v8"];
        if (!v8.is_null() && v8.is_object()) {
          json11::Json flags = v8["flags"];
          if (!flags.is_null() && flags.is_string()) {
            const char* flags_str = flags.string_value().c_str();
            v8::V8::SetFlagsFromString(flags_str, strlen(flags_str));
          }
        }
      }
    }

    v8::V8::InitializePlatform(v8_platform_);
    v8::V8::Initialize();
  }

  void Startup() {
    RT_ASSERT(engines_execution_.size() > 0);
    Engine* first_engine = engines_execution_[0];
    RT_ASSERT(first_engine);
    ResourceHandle<EngineThread> st = first_engine->threads().Create(ThreadType::DEFAULT);

    const char* filename = GLOBAL_initrd()->runtime_index_name();
    InitrdFile startup_file = GLOBAL_initrd()->Get(filename);
    if (startup_file.IsEmpty()) {
      printf("Unable to load %s from initrd.\n", filename);
      abort();
    }

    {
      TransportData data;
      data.SetEvalData(startup_file.Data(), startup_file.Size(), "__loader");

      std::unique_ptr<ThreadMessage> msg(new ThreadMessage(ThreadMessage::Type::EVALUATE,
                                         ResourceHandle<EngineThread>(), std::move(data)));
      st.getUnsafe()->PushMessage(std::move(msg));
    }
  }

  uint32_t engines_count() const {
    return engines_.size();
  }

  uint32_t execution_engines_count() const {
    return engines_execution_.size();
  }

  Engine* execution_engine(uint32_t index) const {
    RT_ASSERT(GLOBAL_engines());
    RT_ASSERT(this == GLOBAL_engines());
    RT_ASSERT(index < engines_execution_.size());
    RT_ASSERT(engines_execution_[index]);
    return engines_execution_[index];
  }

  bool is_execution_engine(uint32_t engineid) const {
    RT_ASSERT(GLOBAL_engines());
    RT_ASSERT(this == GLOBAL_engines());
    RT_ASSERT(engineid < engines_.size());
    RT_ASSERT(engines_[engineid]);
    return EngineType::EXECUTION == engines_[engineid]->type();
  }

  void CpuEnter() {
    uint32_t cpu_id = Cpu::id();
    RT_ASSERT(GLOBAL_engines());
    RT_ASSERT(this == GLOBAL_engines());
    RT_ASSERT(cpu_id < cpu_count_);
    RT_ASSERT(cpu_id < engines_.size());
    engines_[cpu_id]->Enter();
  }

  Engine* cpu_engine() const {
    uint32_t cpuid = cpu_id();
    RT_ASSERT(GLOBAL_engines());
    RT_ASSERT(this == GLOBAL_engines());
    RT_ASSERT(cpuid < cpu_count_);
    RT_ASSERT(cpuid < engines_.size());
    RT_ASSERT(engines_[cpuid]);
    return engines_[cpuid];
  }

  static uint32_t cpu_id() {
    return Cpu::id();
  }

  uint32_t MsPerTick() const {
    return 10;
  }

  void Sleep(uint64_t microseconds) {
    uint64_t before = global_ticks_counter_;
    uint64_t wait_ticks = microseconds / 1000 / MsPerTick();
    if (wait_ticks < 1) {
      wait_ticks = 1;
    }

    // Limit to 1 second max
    if (wait_ticks > 100) {
      wait_ticks = 100;
    }

    uint64_t after = before + wait_ticks;

    while (global_ticks_counter_ < after) {
      Cpu::WaitPause();
    }
  }

  void TimerTick(SystemContextIRQ& irq_context) {
    const Engine* cpuengine = cpu_engine();
    global_ticks_counter_++;
    if (cpuengine->is_init()) {
      cpuengine->TimerTick(irq_context);
    } else {
      NonIsolateTick();
    }
  }

  // Special kind of tick generated when no isolates
  // are available in a system. Used for initializion purposes.
  void NonIsolateTick() {
    RT_ASSERT(GLOBAL_engines());
    RT_ASSERT(this == GLOBAL_engines());
    ++_non_isolate_ticks;
  }

  void NonIsolateSleep(uint32_t ms) const {
    RT_ASSERT(GLOBAL_engines());
    RT_ASSERT(this == GLOBAL_engines());
    if (0 == ms) {
      return;
    }
    RT_ASSERT(MsPerTick() > 0);

    uint32_t cpuid = cpu_id();
    RT_ASSERT(cpuid < engines_.size());
    RT_ASSERT(!engines_[cpuid]->is_init());

    uint32_t sleep_ticks = ms / MsPerTick();
    if (sleep_ticks == 0) {
      sleep_ticks = 1;
    }

    uint64_t required_ticks = 0;
    {
      required_ticks = _non_isolate_ticks + sleep_ticks;
    }

    while (true) {
      uint64_t non_isolate_ticks = 0;
      {
        non_isolate_ticks = _non_isolate_ticks;
      }

      if (non_isolate_ticks > required_ticks) {
        break;
      }
      Cpu::WaitPause();
    }
  }

  AcpiManager* acpi_manager();

  void* AllocateBuffer(size_t length) {
    void* ptr = calloc(1, length);
    if (ptr) {
      buffers_size_ += length;
      ++buffers_count_;
    }
    return ptr;
  }

  void* AllocateUninitializedBuffer(size_t length) {
    void* ptr = malloc(length);
    if (ptr) {
      buffers_size_ += length;
      ++buffers_count_;
    }
    return ptr;
  }

  void FreeBuffer(void* ptr, size_t length) {
    if (!ptr) {
      return;
    }

    buffers_size_ -= length;
    --buffers_count_;
    free(ptr);
  }

  uint64_t buffers_size() const {
    return buffers_size_;
  }
  uint64_t buffers_count() const {
    return buffers_count_;
  }

  V8Platform* v8_platform() const {
    return v8_platform_;
  }

  ~Engines() = delete;
  DELETE_COPY_AND_ASSIGN(Engines);
private:
  uint32_t cpu_count_;
  std::vector<Engine*> engines_;
  std::vector<Engine*> engines_execution_;
  AcpiManager* _acpi_manager;
  uint64_t buffers_size_;
  uint64_t buffers_count_;
  volatile uint64_t _non_isolate_ticks;

  V8Platform* v8_platform_;
  std::atomic<uint64_t> global_ticks_counter_;
};

} // namespace rt
