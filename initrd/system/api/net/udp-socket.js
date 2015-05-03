var netError = require('../../net2/net-error');

function UDPSocket() {
  if (!(this instanceof UDPSocket)) {
    throw new Error('constructor requires "new"');
  }
}

module.exports = UDPSocket;
