// Copyright 2014-2015 runtime.js project authors
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

#pragma once

const char INIT_JS[] = R"JAVASCRIPT(
// JS code to prepare runtime.js environment
global.console = (() => {
  var times = {};

  return {
    log: __SYSCALL.log,
    error: __SYSCALL.log,
    time: function(label) {
      times['l' + label] = Date.now();
    },
    timeEnd: function(label) {
      var time = times['l' + label];
      if ('undefined' === typeof time) {
        return;
      }

      var d = Date.now() - time;
      __SYSCALL.log(label + ': ' + d/1000 + 'ms' + '\n');
      times['l' + label] = void 0;
    },
  };
})();

(() => {
  const promises = new WeakMap();
  const setPromiseHandlers = __SYSCALL._setPromiseHandlers;
  __SYSCALL._setPromiseHandlers = void 0;
  let pendingTask = false;
  let pendingPromises = [];

  function rejected(promise, reason) {
    if (promises.has(promise)) {
      return;
    }

    promises.set(promise, false);
    pendingPromises.push([promise, reason]);
    setTask();
  }

  function rejectedHandled(promise) {
    if (!promises.has(promise)) {
      return;
    }

    const hasBeenNotified = promises.get(promise);
    promises.delete(promise);

    if (hasBeenNotified) {
      if (typeof global.onrejectionhandled === 'function') {
        setImmediate(() => global.onrejectionhandled({ promise }));
      } else {
        if (typeof global.onunhandledrejection !== 'function') {
          console.log('Unhandled promise rejection has been handled.');
        }
      }
    }
  }

  function setTask() {
    if (pendingTask) {
      return;
    }

    pendingTask = true;
    setImmediate(() => {
      pendingTask = false;

      for (let i = 0; i < pendingPromises.length; ++i) {
        let [promise, reason] = pendingPromises[i];
        if (!promises.has(promise)) {
          return;
        }

        promises.set(promise, true);

        if (typeof global.onunhandledrejection === 'function') {
          setImmediate(() => global.onunhandledrejection({ promise, reason }));
        } else {
          if (reason instanceof Error) {
            console.log('Possibly unhandled promise rejection: ' + String(reason.stack));
          } else {
            console.log('Possibly unhandled promise rejection: ' + String(reason));
          }
        }
      }

      pendingPromises = [];
    });
  }

  setPromiseHandlers(rejected, rejectedHandled);
})();
)JAVASCRIPT";
