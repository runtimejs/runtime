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

// NOTE: This script is executed in every context automatically
var console = (function(undef) {
    var stdout = null;
    var stderr = null;
    var times = {};

    function getStdout() {
        if (null === stdout) {
            stdout = isolate.env.stdout;
        }

        return stdout;
    }

    return {
        log: function() {
            var s = Array.prototype.join.call(arguments, ' ');
            getStdout()(s + '\n');
        },
        error: function() {
            if (null === stderr) {
                stderr = isolate.env.stderr;
            }

            var s = Array.prototype.join.call(arguments, ' ');
            stderr(s + '\n');
        },
        time: function(label) {
            times['l' + label] = Date.now();
        },
        timeEnd: function(label) {
            var time = times['l' + label];
            if ('undefined' === typeof time) {
                return;
            }

            var d = Date.now() - time;
            getStdout()(label + ': ' + d/1000 + 'ms' + '\n');
            times['l' + label] = undef;
        },
    };
})();

// CommonJS loader
var exports;
var module = {};

var require = (function() {
    var cache = {'': {exports: {}}};
    var requireStack = [''];
    exports = module.exports = cache[''].exports;

    function pushExports(path) {
        // save current exports state
        var currentPath = requireStack[requireStack.length - 1];
        cache[currentPath].exports = module.exports;

        // load new exports
        if ('undefined' === typeof cache[path]) {
            cache[path] = {exports: {}};
        }

        requireStack.push(path);
        module = {};
        exports = module.exports = cache[path].exports;
    }

    function popExports() {
        // save current exports state
        var currentPath = requireStack.pop();
        var result = cache[currentPath].exports = module.exports;

        // restore previous state
        var path = requireStack[requireStack.length - 1];
        module = {};
        exports = module.exports = cache[path].exports;

        return result;
    }

    function canonicalize(path) {
        var currentPath = requireStack[requireStack.length - 1];
        var dirComponents = currentPath.split('/').slice(0, -1);
        var pathComponents = path.split('/').filter(function(x) {
            return '' !== x;
        });

        if (0 === pathComponents.length) {
            throw new Error('INVALID_PATH');
        }

        var loadPath;
        if ('.' === pathComponents[0]) {
            loadPath = dirComponents.concat(pathComponents);
        } else {
            loadPath = pathComponents;
        }

        return loadPath.filter(function(x) { return '.' !== x }).join('/');
    }

    function readFile(path) {
        try {
            return runtime.syncRPC(isolate.system.fs.current({
                action: 'readFile',
                path: path,
            }));
        } catch (err) {
            if ('NOT_FOUND' === err.message) {
                throw new Error('require: file "'+ path +'" not found')
            }

            throw err;
        }
    }

    return function require(path) {
        path = canonicalize(path) + '.js';

        var result;
        if ('undefined' === typeof cache[path]) {
            var fileContent = readFile(path);
            pushExports(path);
            isolate.eval(fileContent, path);
            result = popExports();

            if ('undefined' === typeof result) {
                cache[path] = {};
            }
        } else {
            result = cache[path].exports;
        }

        return result;
    };
})();

(function(__native) {
    "use strict";

    /**
     * Helper function to support IPC function calls
     */
    function RPC_CALL(fn, threadPtr, argsArray, promiseid) {
        if (null === fn) {
            // Invalid function call
            __native.callResult(false, threadPtr, promiseid, null);
            return;
        }

        var ret;
        try {
            ret = fn.apply(this, argsArray);
        } catch (err) {
            __native.callResult(false, threadPtr, promiseid, err);
            throw err;
        }

        if (ret instanceof Promise) {
            if (!ret.then) return;

            ret.then(function(result) {
                __native.callResult(true, threadPtr, promiseid, result);
            }, function(err) {
                __native.callResult(false, threadPtr, promiseid, err);
            }).catch(function(err) {
                __native.callResult(false, threadPtr, promiseid, err);
            });

            return;
        }

        if (ret instanceof Error) {
            __native.callResult(false, threadPtr, promiseid, ret);
        } else {
            __native.callResult(true, threadPtr, promiseid, ret);
        }
    };

    __native.installInternals({
        callWrapper: RPC_CALL,
    });
});
// No more code here
