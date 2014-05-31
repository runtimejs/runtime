// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

rt.log('Loading system...');

var injector = (function() {
    var services = new Map();

    function getService(name) {
        if (services.has(name)) {
            return services.get(name);
        }

        var d = {
            name: name,
            resolve: null,
            reject: null,
            promise: null,
        };

        d.promise = new Promise(function(resolve, reject) {
            d.resolve = resolve;
            d.reject = reject;
        });

        services.set(name, d);
        return d;
    }

    return {
        set: function(name, inject, fn) {
            if ('string' !== typeof name) {
                throw new Error('invalid service name');
            }

            if (!Array.isArray(inject)) {
                throw new Error('invalid service inject list');
            }

            Promise.all(inject.map(function(depName) {
                if ('string' !== typeof depName) {
                    throw new Error('invalid dependency service name');
                }

                return getService(depName).promise;
            })).then(function(deps) {
                getService(name).resolve(fn.apply(null, deps));
            }).catch(function(err) {
                rt.log(err.stack);
            });
        },
        get: function(value) {
            if (Array.isArray(value)) {
                return Promise.all(value.map(function(name) {
                    return getService(name).promise;
                }));
            }

            if ('string' !== typeof value) {
                throw new Error('invalid service name');
            }

            return getService(value).promise;
        },
    };
})();

(function(resources) {
    var procManager = resources.processManager;

    rt.initrdRequire('/system/device-manager.js', {
        resources: resources,
        injector: injector,
    });

    injector.set('userSpace', ['textVideo', 'keyboard'], function(textVideo, keyboard) {

        procManager.create(rt.initrdText("/app/terminal.js"), {
            resources: resources,
            textVideo: textVideo,
            keyboard: keyboard,
        });

        return {};
    });

})(rt.resources());
