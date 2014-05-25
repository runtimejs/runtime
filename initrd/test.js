// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Use this file for testing, by default it prints arguments

(function(args) {
    "use strict";
    rt.log('Test args', JSON.stringify(args));
})(rt.args());
