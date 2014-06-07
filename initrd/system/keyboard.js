// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/**
 * Keyboard service
 */
define('keyboard', [],
function() {
    "use strict";

    var listeners = [];

    return {
        /**
         * Driver interface
         */
        driver: {
            register: function(data) {
                // Not implemented yet
            },
            event: function(keyinfo) {
                listeners.forEach(function(listener) {
                    listener(keyinfo);
                });
            },
        },
        /**
         * Client interface
         */
        client: {
            addListener: function(fn) {
                listeners.push(fn);
            },
        },
    };
});
