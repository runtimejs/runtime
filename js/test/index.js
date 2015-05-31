var test = require('tape');
var stream = test.createStream();
var shutdown = require('runtimejs').machine.shutdown;

stream.on('data', function (v) {
  if (v[v.length - 1] === '\n') {
    v = v.slice(0, -1);
  }
  console.log(v);
});

stream.on('end', shutdown);

require('./buffers');
require('./virtio');
require('./net');
