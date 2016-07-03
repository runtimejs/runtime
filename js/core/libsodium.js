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

var lib = require('./resources').libsodium;
var constants = lib.crypto_constants();

// Helper function to convert hex results into Uint8Arrays.
function hexToU8(hexStr) {
  var u8 = new Uint8Array(hexStr.length/2);
  for (var i = 0; i < (hexStr.length/2); i++) {
    u8[i] = parseInt(hexStr.substr(i*2, 2), 16);
  }
  return u8;
}

function throwErr(funcName, argName, i, msg) {
  throw new Error(funcName + ': ' + argName + ' (argument ' + i + ') ' + msg + '.');
}

function stringOrU8(arg, funcName, argName, i, msg) {
  var ret = arg;
  if (!(arg instanceof Uint8Array)) {
    if (typeof arg === 'string' || (arg instanceof String)) {
      ret = new Uint8Array(arg.length);
      for (var i = 0; i < arg.length; i++) {
        ret[i] = arg.charCodeAt(i);
      }
    } else {
      throwErr(funcName, argName, i, (msg ? msg : 'must be a string or Uint8Array'));
    }
  }
  return ret;
}

function isNumber(arg, funcName, argName, i, msg) {
  if (typeof arg !== 'number' && !(arg instanceof Number)) {
    throwErr(funcName, argName, i, (msg ? msg : 'must be a number'));
  }
  return arg;
}

module.exports = {
  crypto_secretbox_easy: function(data, key) {
    var dataArr = stringOrU8(data, 'crypto_secretbox_easy', 'data', 0);
    var keyArr = stringOrU8(key, 'crypto_secretbox_easy', 'key', 1);

    var nonceArr = runtime.random.getRandomValues(constants.crypto_secretbox_NONCEBYTES);

    var cipher = lib.crypto_secretbox_easy(dataArr, keyArr, nonceArr);
    if (!cipher) {
      throw new Error('crypto_secretbox_easy: error creating box.');
    }
    return {
      ciphertext: hexToU8(cipher),
      nonce: nonceArr
    };
  },
  crypto_secretbox_open_easy: function(cipher, key, nonce) {
    var cipherArr = stringOrU8(cipher, 'crypto_secretbox_open_easy', 'cipher', 0);
    var keyArr = stringOrU8(key, 'crypto_secretbox_open_easy', 'key', 1);
    var nonceArr = stringOrU8(nonce, 'crypto_secretbox_open_easy', 'nonce', 2);

    var decipher = lib.crypto_secretbox_open_easy(cipherArr, keyArr, nonceArr);
    if (!decipher) {
      throw new Error('crypto_secretbox_open_easy: error decrypting box.');
    }
    return hexToU8(decipher);
  },
  crypto_auth: function(data, key) {
    var dataArr = stringOrU8(data, 'crypto_auth', 'data', 0);
    var keyArr;
    if (key === null || key === undefined) {
      keyArr = runtime.random.getRandomValues(constants.crypto_auth_KEYBYTES);
    } else {
      keyArr = stringOrU8(key, 'crypto_auth', 'key', 1, 'must be unspecified, a string, or Uint8Array');
    }

    var mac = lib.crypto_auth(dataArr, keyArr);
    if (!mac) {
      throw new Error('crypto_auth: error creating tag.');
    }
    return {
      mac: hexToU8(mac),
      key: keyArr
    };
  },
  crypto_auth_verify: function(mac, key, data) {
    var macArr = stringOrU8(mac, 'crypto_auth_verify', 'MAC', 0);
    var keyArr = stringOrU8(key, 'crypto_auth_verify', 'key', 1);
    var dataArr = stringOrU8(data, 'crypto_auth_verify', 'data', 2);

    return lib.crypto_auth_verify(macArr, keyArr, dataArr);
  },
  crypto_aead_chacha20poly1305_encrypt: function(data, key, addData) {
    var dataArr = stringOrU8(data, 'crypto_aead_chacha20poly1305_encrypt', 'data', 0);
    var keyArr = stringOrU8(key, 'crypto_aead_chacha20poly1305_encrypt', 'key', 1);
    var addDataArr = stringOrU8(key, 'crypto_aead_chacha20poly1305_encrypt', 'additional data', 2);

    var nonceArr = runtime.random.getRandomValues(constants.crypto_aead_chacha20poly1305_NPUBBYTES);

    var cipher = lib.crypto_aead_chacha20poly1305_encrypt(dataArr, keyArr, nonceArr, addDataArr);
    if (!cipher) {
      throw new Error('crypto_aead_chacha20poly1305_encrypt: error creating box.');
    }
    return {
      ciphertext: hexToU8(cipher.ciphertext),
      nonce: nonceArr,
      length: cipher.ciphertext_len
    };
  },
  crypto_aead_chacha20poly1305_decrypt: function(cipher, cipherLength, key, nonce, addData) {
    var cipherArr = stringOrU8(cipher, 'crypto_aead_chacha20poly1305_decrypt', 'cipher', 0);
    var cipherLen = isNumber(cipherLength, 'crypto_aead_chacha20poly1305_decrypt', 'cipher length', 1);
    var keyArr = stringOrU8(key, 'crypto_aead_chacha20poly1305_decrypt', 'key', 2);
    var nonceArr = stringOrU8(nonce, 'crypto_aead_chacha20poly1305_decrypt', 'nonce', 3);
    var addDataArr = stringOrU8(key, 'crypto_aead_chacha20poly1305_decrypt', 'additional data', 4);

    var decipher = lib.crypto_aead_chacha20poly1305_decrypt(cipherArr, keyArr, nonceArr, addDataArr, cipherLen);
    if (!decipher) {
      throw new Error('crypto_aead_chacha20poly1305_decrypt: error decrypting box.');
    }
    return hexToU8(decipher.deciphertext);
  },
  crypto_aead_aes256gcm_is_available: function() {
    // AES-256 GCM isn't supported on QEMU's system-x86_64
    return false;
  },
  crypto_aead_aes256gcm_encrypt: function(data, key, addData) {
    // AES-256 GCM isn't supported on QEMU's system-x86_64
    throw new Error('CPU not supported');
    /*var dataArr = stringOrU8(data, 'crypto_aead_aes256gcm_encrypt', 'data', 0);
    var keyArr = stringOrU8(key, 'crypto_aead_aes256gcm_encrypt', 'key', 1);
    var addDataArr = stringOrU8(key, 'crypto_aead_aes256gcm_encrypt', 'additional data', 2);
    var nonceArr = runtime.random.getRandomValues(constants.crypto_aead_aes256gcm_NPUBBYTES);
    var cipher = lib.crypto_aead_aes256gcm_encrypt(dataArr, keyArr, nonceArr, addDataArr);
    if (!cipher) {
      throw new Error('crypto_aead_aes256gcm_encrypt: error creating box.');
    }
    if (cipher instanceof Error) throw cipher;
    return {
      ciphertext: hexToU8(cipher.ciphertext),
      nonce: nonceArr,
      length: cipher.ciphertext_len
    };*/
  },
  crypto_aead_aes256gcm_decrypt: function(cipher, cipherLength, key, nonce, addData) {
    // AES-256 GCM isn't supported on QEMU's system-x86_64
    throw new Error('CPU not supported');
    /*var cipherArr = stringOrU8(cipher, 'crypto_aead_aes256gcm_decrypt', 'cipher', 0);
    var cipherLen = isNumber(cipherLength, 'crypto_aead_aes256gcm_decrypt', 'cipher length', 1);
    var keyArr = stringOrU8(key, 'crypto_aead_aes256gcm_decrypt', 'key', 2);
    var nonceArr = stringOrU8(nonce, 'crypto_aead_aes256gcm_decrypt', 'nonce', 3);
    var addDataArr = stringOrU8(key, 'crypto_aead_aes256gcm_decrypt', 'additional data', 4);
    var decipher = lib.crypto_aead_aes256gcm_decrypt(cipherArr, keyArr, nonceArr, addDataArr, cipherLen);
    if (!decipher) {
      throw new Error('crypto_aead_aes256gcm_decrypt: error decrypting box.');
    }
    if (decipher instanceof Error) throw decipher;
    return hexToU8(decipher.deciphertext);*/
  },
  crypto_box_easy: function(data, pk, sk) {
    var dataArr = stringOrU8(data, 'crypto_box_easy', 'data', 0);
    var pkArr = stringOrU8(pk, 'crypto_box_easy', 'public key', 1);
    var skArr = stringOrU8(sk, 'crypto_box_easy', 'secret key', 2);

    var nonceArr = runtime.random.getRandomValues(constants.crypto_box_NONCEBYTES);

    var cipher = lib.crypto_box_easy(dataArr, pkArr, skArr, nonceArr);
    if (!cipher) {
      throw new Error('crypto_box_easy: error creating box.');
    }
    return {
      ciphertext: hexToU8(cipher),
      nonce: nonceArr
    };
  },
  crypto_box_open_easy: function(cipher, pk, sk, nonce) {
    var cipherArr = stringOrU8(cipher, 'crypto_box_open_easy', 'cipher', 0);
    var pkArr = stringOrU8(pk, 'crypto_box_open_easy', 'public key', 1);
    var skArr = stringOrU8(sk, 'crypto_box_open_easy', 'secret key', 1);
    var nonceArr = stringOrU8(nonce, 'crypto_box_open_easy', 'nonce', 2);

    var decipher = lib.crypto_box_open_easy(cipherArr, pkArr, skArr, nonceArr);
    if (!decipher) {
      throw new Error('crypto_box_open_easy: error decrypting box.');
    }
    return hexToU8(decipher);
  },
  crypto_box_keypair: function() {
    var keypair = lib.crypto_box_keypair();
    if (typeof keypair === 'string') throw new Error(keypair);
    return keypair;
  },
  crypto_box_seed_keypair: function(seed) {
    var seedArr = stringOrU8(seed, 'crypto_box_seed_keypair', 'seed', 0);

    var keypair = lib.crypto_box_seed_keypair(seedArr);
    if (typeof keypair === 'string') throw new Error(keypair);
    return keypair;
  }
};

var justConvertHex = [
  {
    funcName: 'randombytes_buf',
    errorInfo: 'error generating randomness.',
    dataVerifier: isNumber,
    argName: 'buffer length'
  },
  {
    funcName: 'crypto_generichash',
    errorInfo: 'error calculating hash.'
  },
  {
    funcName: 'crypto_hash_sha256',
    errorInfo: 'error calculating hash.'
  },
  {
    funcName: 'crypto_hash_sha512',
    errorInfo: 'error calculating hash.'
  }
];

for (var i = 0; i < justConvertHex.length; i++) {
  (function(i) {
    var f = justConvertHex[i];
    module.exports[f.funcName] = function(data) {
      var result = lib[f.funcName]((f.dataVerifier ? f.dataVerifier : stringOrU8)(data, f.funcName, (f.argName ? f.argName : 'data'), 0));
      if (!result) {
        throw new Error(f.funcName + ': ' + (f.errorInfo ? f.errorInfo : 'unknown error.'));
      }
      return hexToU8(result);
    }
  })(i);
}
