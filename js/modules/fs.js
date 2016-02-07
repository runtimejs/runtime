// Copyright 2015-present runtime.js project authors
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

'use strict';
var typeutils = require('typeutils');

function makeErrorNotFound(path, op) {
  return new Error('ENOENT: no such file or directory, ' + op + ' \'' + path + '\'');
}

function normalizePath(components) {
  var r = [];
  for (var i = 0; i < components.length; ++i) {
    var p = components[i];
    if ('' === p || '.' === p) {
      continue;
    }

    if ('..' === p) {
      if (r.length > 0) {
        r.pop();
      } else {
        return null;
      }
    } else {
      r.push(p);
    }
  }

  return r;
}

// This function assumes current directory '/'. It is not
// possible to change it.
function toAbsolutePath(path) {
  if (typeof path !== 'string') {
    return null;
  }

  var parts = path.split('/');
  var n = normalizePath(parts);
  if (!n) {
    return null;
  }

  return '/' + n.join('/');
}

function readFileImpl(fnName, path, opts) {
  if (!typeutils.isString(path)) {
    throw new Error('path is not a string');
  }

  var encoding = null;
  if (typeutils.isString(opts)) {
    encoding = opts;
  } else if (typeutils.isObject(opts)) {
    encoding = opts.encoding;
  }

  var absolute = toAbsolutePath(path);
  if (!absolute) {
    return [makeErrorNotFound(path, fnName), null];
  }

  var buf = __SYSCALL.initrdReadFileBuffer(absolute);
  if (!buf) {
    return [makeErrorNotFound(path, fnName), null];
  }

  if (encoding) {
    return [null, new Buffer(buf).toString(encoding)];
  }

  return [null, new Buffer(buf)];
}

exports.readFile = function(path, opts, cb) {
  var options = typeutils.isFunction(opts) ? null : opts;
  var callback = typeutils.isFunction(opts) ? opts : cb;

  if (!typeutils.isFunction(callback)) {
    throw new Error('callback is not a function');
  }

  var [err, buf] = readFileImpl('readFile', path, opts);
  setImmediate(() => callback(err, buf));
};

exports.readFileSync = function(path, opts) {
  var [err, buf] = readFileImpl('readFileSync', path, opts);
  if (err) {
    throw err;
  }

  return buf;
};
