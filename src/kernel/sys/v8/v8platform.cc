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

#include <kernel/v8platform.h>
#include <kernel/platform.h>
#include <stdio.h>
#include <kernel/engines.h>

namespace rt {

V8Platform::V8Platform() {

}

V8Platform::~V8Platform() {

}

void V8Platform::CallOnBackgroundThread(v8::Task* task, v8::Platform::ExpectedRuntime expected_runtime) {
  RT_ASSERT(task);

  // TODO: do not run task immediately here
  // (requires sched() implementation to avoid deadlocks)
  // background_tasks_.push(task);
  task->Run();
}

void V8Platform::CallOnForegroundThread(v8::Isolate* isolate, v8::Task* task) {
  RT_ASSERT(isolate);
  RT_ASSERT(task);
  foreground_tasks_.push(task);
}

void V8Platform::CallDelayedOnForegroundThread(v8::Isolate* isolate, v8::Task* task,
    double delay_in_seconds) {
  RT_ASSERT(isolate);
  RT_ASSERT(task);
  double microsecondsPerSecond = 1000 * 1000;
  uint64_t time_now { GLOBAL_platform()->BootTimeMicroseconds() };
  uint64_t when = time_now + delay_in_seconds * microsecondsPerSecond;
  foreground_delayed_tasks_.Set(task, when);
}

void V8Platform::CallIdleOnForegroundThread(v8::Isolate* isolate, v8::IdleTask* task) {
  RT_ASSERT(isolate);
  RT_ASSERT(task);
  printf("[v8] idle task ignored\n");
}

bool V8Platform::IdleTasksEnabled(v8::Isolate* isolate) {
  RT_ASSERT(isolate);
  return false;
}

double V8Platform::MonotonicallyIncreasingTime() {
  double microsecondsPerSecond = 1000 * 1000;
  return GLOBAL_platform()->BootTimeMicroseconds() / microsecondsPerSecond;
}

void V8Platform::RunBackgroundTasks() {
  while (!background_tasks_.empty()) {
    v8::Task* task = background_tasks_.front();
    RT_ASSERT(task);
    background_tasks_.pop();
#ifdef RUNTIME_DEBUG
    printf("v8 run background\n");
#endif
    task->Run();
  }
}

void V8Platform::RunForegroundTasks() {
  while (!foreground_tasks_.empty()) {
    v8::Task* task = foreground_tasks_.front();
    RT_ASSERT(task);
    foreground_tasks_.pop();
#ifdef RUNTIME_DEBUG
    printf("v8 run foreground\n");
#endif
    task->Run();
  }

  uint64_t ticks_now { GLOBAL_platform()->BootTimeMicroseconds() };
  while (foreground_delayed_tasks_.Elapsed(ticks_now)) {
    v8::Task* task = foreground_delayed_tasks_.Take();
    RT_ASSERT(task);
#ifdef RUNTIME_DEBUG
    printf("v8 run delayed foreground\n");
#endif
    task->Run();
  }
}

} // namespace rt
