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
  if (opts.family && opts.family === 6) return throwIPv6Err(cb);
  opts.query = opts.query || 'A';
  if (hostname === 'localhost' && opts.query === 'A') {
    if (!opts.all) {
      if (cb) cb(null, '127.0.0.1', 4);
    } else {
      if (opts.addrOnly) {
        if (cb) cb(null, ['127.0.0.1']);
      } else {
        if (cb) cb(null, [{address: '127.0.0.1', family: 4}]);
      }
    }
    return;
  }
  runtime.dns.resolve(hostname, {
    query: opts.query
  }, function(err, data) {
    if (err) {
      if (cb) cb(err, null, null);
      return;
    }
    var res;
    var ret = [];
    for (var i = 0; i < data.results.length; i++) {
      res = data.results[i];
      if (!opts.all && i === 0) {
        var addr = res.address.join('.');
        if (cb) cb(null, addr, 4);
        return;
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
      if (cb) cb(new SystemError('dns query failed', exports.NODATA, 'runtime.dns.resolve'), null);
      return;
    }
    if (cb) cb(null, ret);
  });
}

function throwIPv6Err(cb) {
  var err = new SystemError('runtime doesn\'t support IPv6', exports.BADFAMILY);
  if (cb) return cb(err);
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
  throwIPv6Err(cb);
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
