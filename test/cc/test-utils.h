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

#include <cc/test.h>
#include <common/utils.h>

namespace test {

using namespace common;

TEST(Utils) {

    describe("ToString") {
        it("should producte correct results", function {
            char sp[100];
            Utils::ToString<uint64_t>(1000, sp, 10);
            assert_string_eq(sp, "1000");
            Utils::ToString<uint64_t>(0, sp, 10);
            assert_string_eq(sp, "0");
            Utils::ToString<int64_t>(-1, sp, 10);
            assert_string_eq(sp, "-1");
            Utils::ToString<uint64_t>(18446744073709551615ull, sp, 10);
            assert_string_eq(sp, "18446744073709551615");
            Utils::ToString<int64_t>(9223372036854775807ll, sp, 10);
            assert_string_eq(sp, "9223372036854775807");
            Utils::ToString<int64_t>(-9223372036854775807ll, sp, 10);
            assert_string_eq(sp, "-9223372036854775807");
            Utils::ToString<uint64_t>(18446744073709551615ull, sp, 2);
            assert_string_eq(sp, "1111111111111111111111111111111111111111111111111111111111111111");
            Utils::ToString<uint64_t>(18446744073709551615ull, sp, 16);
            assert_string_eq(sp, "ffffffffffffffff");
        });
    }

    describe("Align") {
        it("should return correcly aligned value", function {
            assert_eq(Utils::Align(10, 8), 16);
            assert_eq(Utils::Align(11, 8), 16);
            assert_eq(Utils::Align(12, 8), 16);
            assert_eq(Utils::Align(13, 8), 16);
            assert_eq(Utils::Align(14, 8), 16);
            assert_eq(Utils::Align(15, 8), 16);
            assert_eq(Utils::Align(16, 8), 16);
            assert_eq(Utils::Align(17, 8), 24);
        });
    }
}

} // namespace test


