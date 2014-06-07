// Copyright 2014, runtime.js project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

rt.log('Loading system...');

(function() {
    "use strict";

    /**
     * Create DI injector
     */
    var injector = new Injector();

    /**
     * Pretend this is an AMD loader
     */
    var define = injector.set;
    define.amd = {};

    /**
     * Component provides access to kernel resources
     */
    define('resources', [],
    function() {
        return rt.resources();
    });

    /**
     * Kernel bootstrap component. This loads kernel loader,
     * because it can't load itself
     */
    define('bootstrap', ['resources'],
    function(resources) {
        var loaderFactory = new Function('define',
            resources.loader('/system/kernel-loader.js'));
        loaderFactory(define);
    });

    /**
     * Main kernel component
     */
    define('kernel', ['resources', 'vga', 'keyboard'],
    function(resources, vga, keyboard) {
        resources.processManager.create(rt.initrdText("/app/terminal.js"), {
            textVideo: vga.client,
            keyboard: keyboard.client,
        });

        return {};
    });
})();
