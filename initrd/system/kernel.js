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

isolate.log('Loading system...');

var resources = isolate.data();
console.log = isolate.log;

// CommonJS kernel loader
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
    return resources.natives.initrdText('/system/' + path);
  }
  
  function evalFile(content, path) {
    try {
      isolate.eval('(function(){' + content + '})()', path);
    } catch (err) {
      console.log('Load error \'' + path + '\': ' + err.stack);
      throw new Error('loader errors');
    }
  }

  return function require(path) {
    path = canonicalize(path);

    var result;
    if ('undefined' === typeof cache[path]) {
      var fileContent = readFile(path);
      pushExports(path);
      evalFile(fileContent, path);
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

// Configure resources module
resources = require('resources.js')();

// Components
var keyboard = require('keyboard.js');
var vga = require('driver/vga.js');
var vfs = require('vfs.js');
var net = require('net/net.js');
var pci = require('pci/pci.js');

// Drivers
var ps2kbd = require('driver/ps2kbd.js');

vfs.getInitrdRoot()({
  action: 'spawn',
  path: '/app/terminal.js',
  env: {
    textVideo: vga.client,
    keyboard: keyboard.client,
  }
}).catch(function(err) {
  isolate.log(err.stack);
});
