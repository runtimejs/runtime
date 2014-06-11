// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <kernel/platform.h>
#include <kernel/kernel.h>
#include <unwind.h>

namespace rt {

_Unwind_Reason_Code TraceFn(_Unwind_Context *ctx, void *d) {
    int *depth = (int*)d;
    printf("\t#%d: at %08x\n", *depth, _Unwind_GetIP(ctx));
    (*depth)++;
    return _URC_NO_REASON;
}

void Platform::PrintBacktrace() {
    int depth = 0;
    _Unwind_Backtrace(&TraceFn, &depth);
}

} // namespace rt
