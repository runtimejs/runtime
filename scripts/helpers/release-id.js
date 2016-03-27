var assert = require('assert');

function versionToReleaseId(ver) {
  var parts = String(ver).split('.');
  assert(parts.length === 3);
  var major = Number(parts[0]);
  var minor = Number(parts[1]);
  var patch = Number(parts[2]);
  assert(major < 1024);
  assert(minor < 1024);
  assert(patch < 1024);
  return ((major << 20) | (minor << 10) | patch) >>> 0;
}

module.exports = versionToReleaseId;
