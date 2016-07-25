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

(() => {
  // from https://github.com/runtimejs/runtime-module-loader/blob/master/index.js
  class Loader {
    constructor(existsFileFn, readFileFn, evalScriptFn, builtins = {}, builtinsResolveFrom = '/') {
      const cache = {};
      const builtinsResolveFromComponents = builtinsResolveFrom.split('/');

      function throwError(err) {
        throw err;
      }

      function endsWith(str, suffix) {
        return str.indexOf(suffix, str.length - suffix.length) !== -1;
      }

      function normalizePath(components) {
        const r = [];
        for (const p of components) {
          if (p === '') {
            if (r.length === 0) {
              r.push(p);
            }
            continue;
          }

          if (p === '.') {
            continue;
          }

          if (p === '..') {
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

      function loadAsFile(path) {
        if (existsFileFn(path)) return path;
        if (existsFileFn(`${path}.js`)) return `${path}.js`;
        if (existsFileFn(`${path}.json`)) return `${path}.json`;
        if (existsFileFn(`${path}.node`)) return `${path}.node`;

        return null;
      }

      function getPackageMain(packageJsonFile) {
        const json = readFileFn(packageJsonFile);
        let parsed = null;
        try {
          parsed = JSON.parse(json);
        } catch (e) {
          throwError(new Error(`package.json '${packageJsonFile}' parse error`));
        }

        if (parsed.runtime) {
          if (typeof parsed.runtime === 'string') {
            return parsed.runtime;
          }
          throwError(new Error(`package.json '${packageJsonFile}' runtime field value is invalid`));
        }

        return parsed.main || 'index.js';
      }

      function loadAsDirectory(path, ignoreJson) {
        let mainFile = 'index';
        let dir = false;
        if (!ignoreJson && existsFileFn(`${path}/package.json`)) {
          mainFile = getPackageMain(`${path}/package.json`) || 'index';
          dir = true;
        }

        const normalizedPath = normalizePath(path.split('/').concat(mainFile.split('/')));
        if (!normalizedPath) {
          return null;
        }

        const s = normalizedPath.join('/');
        const res = loadAsFile(s);
        if (res) {
          return res;
        }

        if (dir) {
          return loadAsDirectory(s, true);
        }

        return null;
      }

      function loadNodeModules(dirComponents, parts) {
        let count = dirComponents.length;

        while (count-- > 0) {
          let p = dirComponents.slice(0, count + 1);
          if (p.length === 0) {
            continue;
          }

          if (p[p.length - 1] === 'node_modules') {
            continue;
          }

          p.push('node_modules');
          p = p.concat(parts);

          const normalizedPath = normalizePath(p);
          if (!normalizedPath) {
            continue;
          }

          const s = normalizedPath.join('/');
          const loadedPath = loadAsFile(s) || loadAsDirectory(s, false) || null;
          if (loadedPath) {
            return loadedPath;
          }
        }

        return null;
      }

      function resolve(module, pathOpt = '') {
        let path = String(pathOpt);

        let resolveFrom = module.dirComponents;

        if (Object.prototype.hasOwnProperty.call(builtins, path)) {
          path = builtins[path];
          resolveFrom = builtinsResolveFromComponents;
        }

        const pathComponents = path.split('/');
        const firstPathComponent = pathComponents[0];

        // starts with ./ ../  or /
        if (firstPathComponent === '.' ||
          firstPathComponent === '..' ||
          firstPathComponent === '') {
          const combinedPathComponents = (firstPathComponent === '') ?
            pathComponents :
            resolveFrom.concat(pathComponents);

          const normalizedPath = normalizePath(combinedPathComponents);
          if (!normalizedPath) {
            return null;
          }

          const pathStr = normalizedPath.join('/');
          const loadedPath = loadAsFile(pathStr) || loadAsDirectory(pathStr, false) || null;
          return loadedPath;
        }

        return loadNodeModules(resolveFrom, pathComponents);
      }

      class Module {
        constructor(pathComponents) {
          this.dirComponents = pathComponents.slice(0, -1);
          this.pathComponents = pathComponents;
          this.filename = pathComponents.join('/');
          this.dirname = this.dirComponents.length > 1 ? this.dirComponents.join('/') : '/';
          this.exports = {};
        }
        require(path) {
          let module = this;
          const resolvedPath = resolve(module, path);
          if (!resolvedPath) {
            throwError(new Error(`Cannot resolve module '${path}' from '${module.filename}'`));
          }

          // eval file
          const pathComponents = resolvedPath.split('/');
          const displayPath = resolvedPath;
          const cacheKey = pathComponents.join('/');
          if (cache[cacheKey]) {
            return cache[cacheKey].exports;
          }

          const currentModule = global.module;
          module = new Module(pathComponents);
          cache[cacheKey] = module;
          global.module = module;

          if (endsWith(resolvedPath, '.node')) {
            throwError(new Error(`Native Node.js modules are not supported '${resolvedPath}'`));
          }

          const content = readFileFn(resolvedPath);
          if (!content) throwError(new Error(`Cannot load module '${resolvedPath}'`));

          if (endsWith(resolvedPath, '.json')) {
            module.exports = JSON.parse(content);
          } else {
            /* eslint-disable max-len */
            evalScriptFn(
              `((require,exports,module,__filename,__dirname) => {${content}})(((m) => {return function(path){return m.require(path)}})(global.module),global.module.exports,global.module,global.module.filename,global.module.dirname)`,
              displayPath);
            /* eslint-enable max-len */
          }

          global.module = currentModule;
          return module.exports;
        }
      }

      this.require = (path) => {
        const rootModule = new Module(['', '']);
        global.module = rootModule;
        return rootModule.require(path);
      };
    }
  }
  // end

  const files = {};
  for (const file of __SYSCALL.initrdListFiles()) {
    files[file] = true;
  }

  function fileExists(path) {
    return !!files[path];
  }

  const runtimePackagePath = __SYSCALL.initrdGetKernelIndex().split('/').slice(0, -1).join('/');
  const loader = new Loader(fileExists, __SYSCALL.initrdReadFile, __SYSCALL.eval, {
    assert: 'assert',
    events: 'events',
    buffer: 'buffer',
    process: './modules/process.js',
    console: './modules/console.js',
    constants: 'constants-browserify',
    fs: './modules/fs.js',
    os: './modules/os.js',
    net: './modules/net.js',
    dns: './modules/dns.js',
    punycode: 'punycode',
    querystring: 'querystring-es3',
    string_decoder: 'string_decoder',
    path: 'path-browserify',
    url: 'url',
    stream: './modules/stream.js',
    inherits: './modules/inherits.js',
    sys: 'util/util.js',
    util: 'util/util.js',
  }, runtimePackagePath);

  loader.require(`${runtimePackagePath}/index.js`);

  global.process = loader.require('process');
  global.Buffer = loader.require('buffer').Buffer;
  const stream = loader.require('stream');
  class StdoutStream extends stream.Writable {
    _write(chunk, encoding, callback) {
      __SYSCALL.write(String(chunk));
      callback();
    }
  }
  class StderrStream extends stream.Writable {
    _write(chunk, encoding, callback) {
      __SYSCALL.write(String(chunk));
      callback();
    }
  }
  class TermoutStream extends stream.Writable {
    _write(chunk, encoding, callback) {
      runtime.stdio.defaultStdio.write(String(chunk));
      callback();
    }
  }
  class TermerrStream extends stream.Writable {
    _write(chunk, encoding, callback) {
      runtime.stdio.defaultStdio.writeError(String(chunk));
      callback();
    }
  }
  process.stdout = new StdoutStream();
  process.stderr = new StderrStream();
  process.termout = new TermoutStream();
  process.termerr = new TermerrStream();
  loader.require('console');
  loader.require('/');
})();
