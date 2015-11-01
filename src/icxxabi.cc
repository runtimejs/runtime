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

void* __dso_handle = 0;

extern "C" int __cxa_atexit(void (*f)(void*), void* objptr, void* dso) {
  return 0;
}

extern "C" void __cxa_pure_virtual() {
  // Do nothing.
}

namespace __cxxabiv1 {
__extension__ typedef int __guard __attribute__((mode(__DI__)));

extern "C" int __cxa_guard_acquire (__guard*);
extern "C" void __cxa_guard_release (__guard*);
extern "C" void __cxa_guard_abort (__guard*);
extern "C" int __cxa_guard_acquire (__guard* g) {
  return !*(char*)(g);
}
extern "C" void __cxa_guard_release (__guard* g) {
  *(char*)g = 1;
}
extern "C" void __cxa_guard_abort (__guard*) {

}
}
