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

Object.assign(exports, {
  NODATA: 'ENODATA',
  BADFAMILY: 'EBADFAMILY',
  FORMERR: 'EFORMERR',
  SERVFAIL: 'ESERVFAIL',
  NOTFOUND: 'ENOTFOUND',
  NOTIMP: 'ENOTIMP',
  REFUSED: 'EREFUSED',
  BADQUERY: 'EBADQUERY',
  BADNAME: 'EBADNAME',
  BADRESP: 'EBADRESP',
  CONNREFUSED: 'ECONNREFUSED',
  TIMEOUT: 'ETIMEOUT',
  EOF: 'EEOF',
  FILE: 'EFILE',
  NOMEM: 'ENOMEM',
  DESTRUCTION: 'EDESTRUCTION',
  BADSTR: 'EBADSTR',
  BADFLAGS: 'EBADFLAGS',
  NONAME: 'ENONAME',
  BADHINTS: 'EBADHINTS',
  NOTINITIALIZED: 'ENOTINITIALIZED',
  LOADIPHLPAPI: 'ELOADIPHLPAPI',
  ADDRGETNETWORKPARAMS: 'EADDRGETNETWORKPARAMS',
  CANCELLED: 'ECANCELLED'
});

let servers = [
  '8.8.8.8'
];

function lookup(hostname, opts, cb) {
  return new Promise(function(resolve, reject) {
    if (opts.family && opts.family === 6) return throwIPv6Err(cb, reject);
    runtime.dns.resolve(hostname, {
      query: opts.query || 'A'
    }, function(err, data) {
      if (err) {
        if (cb) cb(err, null, null);
        reject(err);
        return;
      }
      var res;
      var ret = [];
      for (var i = 0; i < data.results.length; i++) {
        res = data.results[i];
        if (!opts.all && i === 0) {
          var addr = res.address.join('.');
          if (cb) cb(null, addr, 4);
          resolve({ address: addr, family: 4 });
          break;
        } else {
          switch (res.record) {
            case 'A':
              if (opts.addrOnly) {
                ret.push(res.address.join('.'));
              } else {
                ret.push({
                  address: res.address.join('.'),
                  family: 4
                });
              }
              break;
          }
        }
      }
      if (ret.length === 0) {
        var err = new SystemError('dns query failed', exports.NODATA, 'runtime.dns.resolve');
        if (cb) cb(err, null);
        reject(err);
        return;
      }
      if (cb) cb(null, ret);
      resolve(ret);
    });
  });
}

function throwIPv6Err(cb, reject) {
  var err = new SystemError('runtime doesn\'t support IPv6', exports.BADFAMILY);
  if (cb || reject) {
    if (cb) cb(err);
    if (reject) reject(err);
    return;
  }
  throw err;
}

exports.getServers = function() {
  return servers;
}

exports.lookup = function(hostname, opts, cb) {
  if (typeof opts === 'function') {
    cb = opts;
    opts = null;
  }
  if (typeof opts === 'undefined' || opts === null) opts = {};
  if (typeof opts === 'number' || opts instanceof Number) {
    opts = {
      family: opts
    };
  }

  return lookup(hostname, opts, cb);
}

exports.resolve4 = function(hostname, cb) {
  return lookup(hostname, {
    all: true,
    addrOnly: true
  }, cb);
}

exports.resolve6 = function(hostname, cb) {
  return new Promise(function(resolve, reject) {
    throwIPv6Err(cb, reject);
  });
}

exports.resolve = function(hostname, rrtype, cb) {
  if (typeof rrtype === 'function') {
    cb = rrtype;
    rrtype = null;
  }
  if (typeof rrtype === 'undefined' || rrtype === null) rrtype = 'A';
  switch (rrtype) {
    case 'A':
      return exports.resolve4(hostname, cb);
      break;
    case 'AAAA':
      return exports.resolve6(hostname, cb);
      break;
  }
}
