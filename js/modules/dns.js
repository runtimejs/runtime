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

const { SystemError } = require('./errors');

const names = [
  'NODATA',
  'BADFAMILY',
  'FORMERR',
  'SERVFAIL',
  'NOTFOUND',
  'NOTIMP',
  'REFUSED',
  'BADQUERY',
  'BADNAME',
  'BADRESP',
  'CONNREFUSED',
  'TIMEOUT',
  'EOF',
  'FILE',
  'NOMEM',
  'DESTRUCTION',
  'BADSTR',
  'BADFLAGS',
  'NONAME',
  'BADHINTS',
  'NOTINITIALIZED',
  'LOADIPHLPAPI',
  'ADDRGETNETWORKPARAMS',
  'CANCELLED',
];
for (const name of names) exports[name] = `E${name}`;

const servers = [
  '8.8.8.8',
];

function throwIPv6Err(cb) {
  const err = new SystemError('runtime doesn\'t support IPv6', exports.BADFAMILY);
  if (cb) {
    return cb(err);
  }
  throw err;
}

function lookup(hostname, opts, cb) {
  if (opts.family && opts.family === 6) {
    return throwIPv6Err(cb);
  }
  opts.query = opts.query || 'A';
  if (hostname === 'localhost' && opts.query === 'A') {
    if (!opts.all) {
      if (cb) {
        cb(null, '127.0.0.1', 4);
      }
    } else {
      if (opts.addrOnly) {
        if (cb) {
          cb(null, ['127.0.0.1']);
        }
      } else {
        if (cb) {
          cb(null, [{
            address: '127.0.0.1',
            family: 4,
          }]);
        }
      }
    }
    return;
  }
  runtime.dns.resolve(hostname, {
    query: opts.query,
  }, (err, data) => {
    if (err) {
      if (cb) {
        cb(err, null, null);
      }
      return;
    }
    const ret = [];
    for (const i of [...data.results.keys()]) {
      const res = data.results[i];
      if (!opts.all && i === 0) {
        const addr = res.address.join('.');
        if (cb) {
          cb(null, addr, 4);
        }
        return;
      }
      switch (res.record) {
        case 'A':
          if (opts.addrOnly) {
            ret.push(res.address.join('.'));
          } else {
            ret.push({
              address: res.address.join('.'),
              family: 4,
            });
          }
          break;
        default:
          break;
      }
    }
    if (ret.length === 0) {
      if (cb) {
        cb(new SystemError('dns query failed', exports.NODATA, 'runtime.dns.resolve'), null);
      }
      return;
    }
    if (cb) {
      cb(null, ret);
    }
  });
}

exports.getServers = () => servers;

exports.lookup = (hostname, optsOpt, cbOpt) => {
  let opts = optsOpt;
  let cb = cbOpt;
  if (typeof opts === 'function') {
    cb = opts;
    opts = null;
  }
  if (typeof opts === 'undefined' || opts === null) opts = {};
  if (typeof opts === 'number' || opts instanceof Number) {
    opts = {
      family: opts,
    };
  }

  return lookup(hostname, opts, cb);
};

exports.resolve4 = (hostname, cb) => lookup(hostname, {
  all: true,
  addrOnly: true,
}, cb);

exports.resolve6 = (hostname, cb) => throwIPv6Err(cb);

exports.resolve = (hostname, rrtypeOpt, cbOpt) => {
  let rrtype = rrtypeOpt;
  let cb = cbOpt;
  if (typeof rrtype === 'function') {
    cb = rrtype;
    rrtype = null;
  }
  if (typeof rrtype === 'undefined' || rrtype === null) {
    rrtype = 'A';
  }
  if (rrtype === 'A') {
    return exports.resolve4(hostname, cb);
  } else if (rrtype === 'AAAA') {
    return exports.resolve6(hostname, cb);
  }
};
