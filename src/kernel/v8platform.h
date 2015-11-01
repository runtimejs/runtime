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

#pragma once

#include <kernel/kernel.h>
#include <v8.h>
#include <include/v8-platform.h>
#include <kernel/timeouts.h>
#include <queue>

namespace rt {

class V8Platform : public v8::Platform {
public:
  V8Platform();
  virtual ~V8Platform();
  virtual void CallOnBackgroundThread(v8::Task* task,
                                      v8::Platform::ExpectedRuntime expected_runtime) override;
  virtual void CallOnForegroundThread(v8::Isolate* isolate, v8::Task* task) override;
  virtual void CallDelayedOnForegroundThread(v8::Isolate* isolate, v8::Task* task,
      double delay_in_seconds) override;
  virtual void CallIdleOnForegroundThread(v8::Isolate* isolate, v8::IdleTask* task) override;
  virtual bool IdleTasksEnabled(v8::Isolate* isolate) override;
  virtual double MonotonicallyIncreasingTime() override;

  void RunBackgroundTasks();
  void RunForegroundTasks();
private:
  std::queue<v8::Task*> background_tasks_;
  std::queue<v8::Task*> foreground_tasks_;
  Timeouts<v8::Task*> foreground_delayed_tasks_;
  DELETE_COPY_AND_ASSIGN(V8Platform);
};

} // namespace rt
