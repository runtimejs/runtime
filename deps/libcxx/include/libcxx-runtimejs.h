// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

// Use libc++ in Emscripten mode
#define __EMSCRIPTEN__

#include <stdlib.h>
#include <bits/alltypes.h>

#ifdef __cplusplus
extern "C" {
#endif

// Add missing type
typedef struct __locale_struct* locale_t;
locale_t __cloc(void);

// Use linux as platform
#ifndef __linux__
#define __linux__
#endif

// Enforce no exceptions
#ifndef _LIBCPP_NO_EXCEPTIONS
#define _LIBCPP_NO_EXCEPTIONS
#endif

// These are quick-and-dirty hacks to make things pretend to work
// We should not use locale functions in kernel
static inline
long long strtoll_l(const char *__nptr, char **__endptr,
    int __base, locale_t __loc) {
  return strtoll(__nptr, __endptr, __base);
}
static inline
long strtol_l(const char *__nptr, char **__endptr,
    int __base, locale_t __loc) {
  return strtol(__nptr, __endptr, __base);
}
static inline
long double strtold_l(const char *__nptr, char **__endptr,
    locale_t __loc) {
  return strtold(__nptr, __endptr);
}
static inline
unsigned long long strtoull_l(const char *__nptr, char **__endptr,
    int __base, locale_t __loc) {
  return strtoull(__nptr, __endptr, __base);
}
static inline
unsigned long strtoul_l(const char *__nptr, char **__endptr,
    int __base, locale_t __loc) {
  return strtoul(__nptr, __endptr, __base);
}

#ifdef __cplusplus
}
#endif

