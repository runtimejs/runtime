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

exports.EOL = '\n';

exports.arch = function() {
  return '';
};

exports.cpus = function() {
  return []
};

exports.endianness = function() {
  return 'LE';
};

exports.freemem = exports.totalmem = function() {
  return Math.pow(2, 32);
};

exports.homedir = function() {
  return '/';
};

exports.hostname = function() {
  return 'runtime';
};

exports.loadavg = function() {
  return [0, 0, 0];
};

exports.networkInterfaces = function() {
  return [];
};

exports.platform = function() {
  return process.platform;
};

exports.release = function() {
  return '0.0.0';
};

exports.tmpdir = function() {
  return '/tmp';
};

exports.type = function() {
  return 'runtime';
};

exports.uptime = process.uptime;
