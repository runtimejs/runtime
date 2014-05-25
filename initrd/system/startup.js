// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

rt.log('Loading system...');

(function(resources) {
    var procManager = resources.processManager;

    procManager.create(rt.initrdText("/system/net.js"), {
        resources: resources,
        fn: function() { rt.log('hi', JSON.stringify(arguments)); return ["a", "b", "c"]; },
    });

/*
    procManager.create(rt.initrdText("/system.device-manager.js"), {
        resources: resources,
    });
*/

})(rt.resources());
