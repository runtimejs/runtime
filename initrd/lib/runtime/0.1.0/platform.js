// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

define('platform', [], function() {
    "use strict";

    return {
        timeout: function(delay) {
            return RUNTIME.timeout(delay >>> 0);
        },
    };
});
