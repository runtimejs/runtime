// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include <test-framework.h>
#include <runtimejs.h>

#include <vector>
#include <stdio.h>

#define TEST(NAME) class Test##NAME : public Test { void GetSpec(TestSpec& it); }; \
    void Test##NAME::GetSpec(TestSpec& it)

#define describe(NAME) it.DescribeSet(NAME);
#define function [] (TestSpec* it)

#define assert_eq(A, B) it->Assert(__FILE__, __LINE__, A == B)
#define assert_string_eq(A, B) it->Assert(__FILE__, __LINE__, 0 == strcmp(A,B))

namespace test {

class TestSpec;
typedef void (*TestFunc)(TestSpec*);

class TestCase {
public:
    TestCase(const char* test, TestFunc func)
        :	_test(test),
            _func(func) { }
    const char* test() const { return _test; }
    TestFunc func() const { return _func; }
private:
    const char* _test;
    TestFunc _func;
};

class TestSpec {
public:
    TestSpec()
        :	_current_failed(0),
            _current_name(nullptr),
            _current_header_print(false),
            _total_completed(0),
            _total_successful(0),
            _total_failed(0) {
        _cases.reserve(128);
    }

    void operator()(const char* test, TestFunc func) {
        _cases.push_back(TestCase(test, func));
    }

    void DescribeSet(const char* name) {
        _describe_scope = name;
    }

    void Assert(const char* file, int line, bool result) {
        if (!result) {
            ++_current_failed;
            PrintTestHeader();
            printf("  Failed: %s:%d.\n", file, line);
        }
    }

    void RunTests() {
        printf("Testing...\n");
        for (const TestCase& cs : _cases) {
            _current_failed = 0;
            _current_name = cs.test();
            _current_header_print = false;
            TestFunc func = cs.func();

            if (nullptr == func) {
                PrintTestHeader();
                printf("  Invalid test function.\n");
                continue;
            }

            func(this);
            if (_current_failed > 0) {
                ++_total_failed;
                printf("  Checks failed: %u.\n", _current_failed);
            } else {
                ++_total_successful;
            }

            ++_total_completed;
        }

        printf("Done. Completed: %u, failed: %u.\n", _total_completed, _total_failed);
    }

    void PrintTestHeader() {
        if (_current_header_print) {
            return;
        }

        _current_header_print = true;

        if (nullptr != _describe_scope) {
            printf("[%s] ", _describe_scope);
        }

        if (nullptr == _current_name) {
            printf("it <null>\n");
        }
        printf("it %s\n", _current_name);

    }

private:
    std::vector<TestCase> _cases;
    const char* _describe_scope;

    uint32_t _current_failed;
    const char* _current_name;
    bool _current_header_print;

    uint32_t _total_completed;
    uint32_t _total_successful;
    uint32_t _total_failed;
};

class Test {
    friend class TestFramework;
    virtual void GetSpec(TestSpec& it) = 0;
};

} // namespace test
