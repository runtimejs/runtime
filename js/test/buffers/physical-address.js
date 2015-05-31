var test = require('tape');
var resources = require('runtimejs/core/resources');

test('buffer crosses page boundary', function(t) {
  // allocate on page boundary
  var buf = resources.memoryRange.block(0x800000 - 12, 24).buffer();
  var u8 = new Uint8Array(buf);
  for (var i = 0; i < u8.length; i++) {
    u8[i] = i;
  }

  var addr = runtime.bufferAddress(u8);
  var b1 = u8.subarray(0, addr[0]);
  var b2 = u8.subarray(addr[0]);
  t.equal(b1.length, 12);
  t.equal(b1[0], 0);
  t.equal(b2.length, 12);
  t.equal(b2[0], 12);
  t.end();
});

test('buffer does not cross page boundary', function(t) {
  var buf = resources.memoryRange.block(0x800000, 24).buffer();
  var u8 = new Uint8Array(buf);
  for (var i = 0; i < u8.length; i++) {
    u8[i] = i;
  }

  var addr = runtime.bufferAddress(u8);
  var b1 = u8.subarray(0, addr[0]);
  t.equal(b1.length, u8.length);
  t.equal(addr[3], 0);
  t.end();
});
