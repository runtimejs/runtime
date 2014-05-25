// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

(function(args) {
    rt.log('net service welcomes you');

    args.fn(1,2,3,[10,20,30]).then(function(val) {
        rt.log('fn returns resolve', val);
    }, function(val) {
        rt.log('fn returns reject', val);
    });
})(rt.args());
