// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

define('utils', [],
function() {
    "use strict";

    function waitFor(conditionFunc, delay, maxRetry) {
        if ('undefined' ===  typeof delay) {
            delay = 1;
        }

        if ('undefined' ===  typeof maxRetry) {
            maxRetry = 0;
        }

        return new Promise(function(resolve, reject) {
            var count = 0;

            if (conditionFunc()) {
                resolve();
                return;
            }

            var timeoutFunc = function() {
                ++count;

                if (0 !== maxRetry && count > maxRetry) {
                    reject();
                    return;
                }

                if (conditionFunc()) {
                    resolve();
                    return;
                }

                rt.timeout(timeoutFunc, delay);
            };

            rt.timeout(timeoutFunc, delay);
        });
    };

    return {
        waitFor: waitFor,
    };
});
