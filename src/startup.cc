// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/**
 * Kernel main function
 */
void main(void* mbt);

/**
 * C++ Kernel entry point as physical address 0x201000,
 * image offset 0x1000
 */
extern "C" void startup_cpp(void* mbt) {
    main(mbt);
}
