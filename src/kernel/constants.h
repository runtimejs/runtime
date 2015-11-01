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

namespace rt {

class Constants {
public:
  static const uint64_t GiB = 1024 * 1024 * 1024;
  static const uint64_t MiB = 1024 * 1024;
  static const uint64_t KiB = 1024;
private:
  Constants() {}
  DELETE_COPY_AND_ASSIGN(Constants);
};

} // namespace rt
