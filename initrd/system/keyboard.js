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
