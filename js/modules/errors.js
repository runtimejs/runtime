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

exports.Error = Error;

class SystemError {
  constructor(message, errcode, call) {
    let msg = '';
    if (errcode) msg += `${errcode}: `;
    if (message) {
      msg += message;
    }
    if (call) msg += `, ${call}`;
    const err = new Error(msg);
    err.code = errcode || '';
    err.syscall = call || '';
    return err;
  }
}

exports.SystemError = SystemError;
