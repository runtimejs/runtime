// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

rt = {};

var __init = (function (__native) {
    "use strict";

    function install(obj, name, value) {
        Object.defineProperty(obj, name, {
            enumerable: false,
            configurable: false,
            writable: false,
            value: value
        });
    };

    function isFunction(x) {
        return typeof(x) === "function";
    };

    function isNumber(x) {
        return typeof(x) === "number";
    };

    function isInteger(x) {
        return isNumber(x) && (x % 1 === 0);
    };

    function isUint32(x) {
        return (isInteger(x) && x >= 0 && x <= 0xffffffff);
    };

    function isString(x) {
        return Object.prototype.toString.call(x) === "[object String]";
    };

    function isArray(x) {
        return Array.isArray(x);
    };

    function isObject(x) {
        return x === Object(x);
    };

    function hasOwnProperty(x, p) {
        return Object.prototype.hasOwnProperty.call(x, p);
    }

    /**
     * Adds a new event to the event-queue.
     * @param {Function} func Event function
     * @return {Undefined}
     */
    install(rt, "tick", function __tick(func) {
        if (!isFunction(func)) {
            throw new TypeError("tick: Argument 0 is not a Function.");
        }
        __native.tick(func);
    });

    /**
     * Schedules a one shot timer to execute passed function after "delay" milliseconds.
     * @param {Function} func Event function
     * @param {Number} delay Interval in milliseconds that fits into Uint32 value
     * @return {Undefined}
     */
    install(rt, "timeout", function __timeout(func, delay) {
        if (!isFunction(func)) {
            throw new TypeError("timeout: Argument 0 is not a Function.");
        }
        if (!isUint32(delay)) {
            throw new TypeError("timeout: Argument 1 is not an Int32 number.");
        }
        __native.timeout(func, delay);
    });

    install(rt, "log", function __log() {
        __native.kernelLog.apply(this, arguments);
    });

    install(rt, "initrdText", function __initrdText(name) {
        if (!isString(name) || "" === name) {
            throw new TypeError("initrdText: Argument 0 is not a String or empty.");
        }
        var v = __native.initrdText(name);
        if (null === v) {
            throw new Error("initrdText: File not found.");
        }
        return v;
    });

    install(rt, "initrdRequire", function __initrdRequire(name) {
        var module = rt.initrdText(name);
        var exports = {};
        var require = function() { throw new Error("require is not supported"); };
        var fn = new Function("exports", "require", module);
        fn(exports, require);
        return exports;
    });

    install(rt, "debug", function __debug() {
        return __native.debug();
    });

    install(rt, "args", function __args() {
        return __native.args();
    });

    var resourcesCache = null;

    install(rt, "resources", function __resources() {

        if (resourcesCache) {
            return resourcesCache;
        }

        var obj = __native.resources();
        resourcesCache = obj;
        return obj;
    });

    var callWrapper = function __callWrapper(fn, threadPtr, argsArray, promiseid) {
        if (null === fn) {
            // Invalid function call
            __native.callResult(false, threadPtr, promiseid, null);
            return;
        }

        var ret = fn.apply(this, argsArray);

        if (ret instanceof Promise) {
            if (!ret.then) return;

            ret.then(function(result) {
                __native.callResult(true, threadPtr, promiseid, result);
            }, function(result) {
                __native.callResult(false, threadPtr, promiseid, result);
            });

            return;
        }

        __native.callResult(true, threadPtr, promiseid, ret);
    };

    __native.installInternals({
        callWrapper: callWrapper,
    });
});

// Keep this as last statement
__init;
