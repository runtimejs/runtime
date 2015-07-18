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

#include <cc/test.h>

// Include tests here
#include <cc/test-utils.h>

namespace test {

TestFramework::TestFramework() {

}

#define GET_SPEC(NAME) static_cast<Test*>(new Test##NAME)->GetSpec(spec);

void TestFramework::RunTests() {
    TestSpec spec;

    GET_SPEC(Utils);

    spec.RunTests();
}

#undef GET_SPEC

} // namespace test
