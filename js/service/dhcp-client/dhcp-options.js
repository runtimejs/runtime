// Copyright 2014-present runtime.js project authors
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
exports.OPTION_SUBNET_MASK = 1;
exports.OPTION_ROUTER = 3;
exports.OPTION_DOMAIN = 6;
exports.OPTION_ADDRESS_TIME = 51;
exports.OPTION_MESSAGE_TYPE = 53;
exports.OPTION_SERVER_ID = 54;

exports.find = function(options, id, minLength) {
  minLength = minLength || 0;

  for (var i = 0; i < options.length; ++i) {
    if (options[i].id === id && options[i].bytes.length >= minLength) {
      return options[i].bytes;
    }
  }

  return null;
};

exports.findAll = function(options, id, minLength) {
  minLength = minLength || 0;
  var result = [];

  for (var i = 0; i < options.length; ++i) {
    if (options[i].id === id && options[i].bytes.length >= minLength) {
      result.push(options[i].bytes);
    }
  }

  return result;
};
