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
var require = (function() {
  var cache = {};

  function Module(file) {
    var pathComponents = file.split('/');
    this.dirname = pathComponents.slice(0, -1).join('/');
    this.filename = pathComponents.join('/') + '.js';
    this.exports = {};
  }

  function join(dirname, path) {
    var dirComponents = dirname.split('/');
    var pathComponents = path.split('/');

    var combined;
    if ('.' === pathComponents[0] || '..' === pathComponents[0]) {
      combined = dirComponents.concat(pathComponents);
    } else {
      combined = pathComponents;
    }

    var r = [];
    for (var i = 0, l = combined.length; i < l; ++i) {
      var p = combined[i];
      if (!p || '.' === p) {
        continue;
      }

      if ('..' === p) {
        if (r.length > 0) {
          r.pop();
        } else {
          throw new Error('cannot resolve module path "' + path + '"');
        }
      } else {
        r.push(p);
      }
    }

    return r.join('/');
  }

  function readFile(path) {
    return resources.natives.initrdText('/system/' + path + '.js');
  }

  function evalFile(module, content, path) {
    var tmp = global.module;
    global.module = module;

    try {
      isolate.eval(
        '(function(exports, module, __filename, __dirname){"use strict";' +
        content +
        '})(global.module.exports, global.module, global.module.filename, global.module.dirname)'
        , '/system/' + path + '.js');
      global.module = tmp;
    } catch (err) {
      global.module = tmp;
      console.log('Load error \'' + path + '\': ' + err.stack);
      throw new Error('loader errors');
    }
  }

  function require(path) {
    if ('string' !== typeof path) {
      throw new Error('invalid module path "' + path + '"');
    }

    path = join(global.module.dirname, path);
    if (cache[path]) {
      return cache[path].exports;
    }

    var module = new Module(path);
    evalFile(module, readFile(path), path);
    cache[path] = module;
    return module.exports;
  };

  global.module = new Module('kernel');
  return require;
})();

// Configure resources module
resources = require('./resources')();

// Components
var keyboard = require('./keyboard');
var vga = require('./driver/vga');
var vfs = require('./vfs');
var net = require('./net/net');
var pci = require('./pci/pci');

// Drivers
var ps2kbd = require('./driver/ps2kbd');

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
