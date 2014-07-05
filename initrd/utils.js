// Copyright 2014 Runtime.JS project authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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

                setTimeout(timeoutFunc, delay);
            };

            setTimeout(timeoutFunc, delay);
        });
    };

    return {
        waitFor: waitFor,
    };
});
