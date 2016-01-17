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
var assert = require('assert');
var typeutils = require('typeutils');
var domainRegex = /^[a-z0-9.-]+$/;

function isDomain(domain) {
  if (!typeutils.isString(domain)) {
    return false;
  }

  if (domain.length > 255) {
    return false;
  }

  if (!domainRegex.test(domain)) {
    return false;
  }

  var labels = domain.split('.');
  for (var i = 0; i < labels.length; ++i) {
    var label = labels[i];
    if (label.length < 1 || label.length > 63) {
      return false;
    }
  }

  return true;
}

module.exports = isDomain;
