// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
