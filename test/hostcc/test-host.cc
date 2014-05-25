// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <stdio.h>
#include <assert.h>
#include <string.h>
#include <printf.h>

#define COMPARE_RESULTS(NAME) \
    printf("Testing %s\n", NAME); \
    printf("  host = %d, wf = %d\n", count_host, count_wf); \
    printf("  host = %s, wf = %s\n", buf_host, buf_wf); \
    assert(count_host == count_wf); \
    assert(0 == strcmp(buf_host, buf_wf)); \
    printf("OK: %s\n\n", NAME)

int main() {
    const char* s1 = "string1";
    int d1 = 10024;
    char c = 'Z';
    const char* s2 = "extra string";

    char buf_host[128];
    char buf_wf[128];
    int count_host = -1;
    int count_wf = -2;

    count_host = sprintf(buf_host, "text %s %d %c abcdef %s 100%%", s1, d1, c, s2);
    count_wf = tfp_sprintf(buf_wf, "text %s %d %c abcdef %s 100%%", s1, d1, c, s2);
    COMPARE_RESULTS("sprintf simple");

    count_host = snprintf(buf_host, 10, "text %s %d %c abcdef %s 100%%", s1, d1, c, s2);
    count_wf = tfp_snprintf(buf_wf, 10, "text %s %d %c abcdef %s 100%%", s1, d1, c, s2);
    COMPARE_RESULTS("snprintf simple");

    buf_host[0] = 'F';
    buf_wf[0] = 'F';
    buf_host[1] = '\0';
    buf_wf[1] = '\0';

    count_host = snprintf(buf_host, -1, "text %s %d %c abcdef %s 100%%", s1, d1, c, s2);
    count_wf = tfp_snprintf(buf_wf, -1, "text %s %d %c abcdef %s 100%%", s1, d1, c, s2);
    COMPARE_RESULTS("snprintf invalid length");

    count_host = snprintf(buf_host, 0, "text %s %d %c abcdef %s 100%%", s1, d1, c, s2);
    count_wf = tfp_snprintf(buf_wf, 0, "text %s %d %c abcdef %s 100%%", s1, d1, c, s2);
    COMPARE_RESULTS("snprintf length = 0");

    count_host = snprintf(buf_host, 1, "%d100%%", d1);
    count_wf = tfp_snprintf(buf_wf, 1, "%d100%%", d1);
    COMPARE_RESULTS("snprintf length = 1");

    count_host = snprintf(buf_host, 2, "%d100%%", d1);
    count_wf = tfp_snprintf(buf_wf, 2, "%d100%%", d1);
    COMPARE_RESULTS("snprintf length = 2");

    return 0;
}
