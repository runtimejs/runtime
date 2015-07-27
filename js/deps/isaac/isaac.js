/* ----------------------------------------------------------------------
 * Copyright (c) 2012 Yves-Marie K. Rinquin
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * ----------------------------------------------------------------------
 *
 * ISAAC is a cryptographically secure pseudo-random number generator
 * (or CSPRNG for short) designed by Robert J. Jenkins Jr. in 1996 and
 * based on RC4. It is designed for speed and security.
 *
 * ISAAC's informations & analysis:
 *   http://burtleburtle.net/bob/rand/isaac.html
 * ISAAC's implementation details:
 *   http://burtleburtle.net/bob/rand/isaacafa.html
 *
 * ISAAC succesfully passed TestU01
 *
 * ----------------------------------------------------------------------
 *
 * Usage:
 *   <script src="isaac.js"></script>
 *   var random_number = isaac.random();
 *
 * Output: [ 0x00000000; 0xffffffff]
 *         [-2147483648; 2147483647]
 *
 */

 /*
  * This sofware has been modified and adapted for use in runtimejs by the runtime.js project authors.
  */


/* js string (ucs-2/utf16) to a 32-bit integer (utf-8 chars, little-endian) array */
function toIntArray(str) {
  var w1, w2, u, r4 = [], r = [], i = 0;
  var s = str + '\0\0\0'; // pad string to avoid discarding last chars
  var l = s.length - 1;

  while(i < l) {
    w1 = s.charCodeAt(i++);
    w2 = s.charCodeAt(i+1);
    if       (w1 < 0x0080) {
      // 0x0000 - 0x007f code point: basic ascii
      r4.push(w1);
    } else if(w1 < 0x0800) {
      // 0x0080 - 0x07ff code point
      r4.push(((w1 >>>  6) & 0x1f) | 0xc0);
      r4.push(((w1 >>>  0) & 0x3f) | 0x80);
    } else if((w1 & 0xf800) != 0xd800) {
      // 0x0800 - 0xd7ff / 0xe000 - 0xffff code point
      r4.push(((w1 >>> 12) & 0x0f) | 0xe0);
      r4.push(((w1 >>>  6) & 0x3f) | 0x80);
      r4.push(((w1 >>>  0) & 0x3f) | 0x80);
    } else if(((w1 & 0xfc00) == 0xd800)
           && ((w2 & 0xfc00) == 0xdc00)) {
      // 0xd800 - 0xdfff surrogate / 0x10ffff - 0x10000 code point
      u = ((w2 & 0x3f) | ((w1 & 0x3f) << 10)) + 0x10000;
      r4.push(((u >>> 18) & 0x07) | 0xf0);
      r4.push(((u >>> 12) & 0x3f) | 0x80);
      r4.push(((u >>>  6) & 0x3f) | 0x80);
      r4.push(((u >>>  0) & 0x3f) | 0x80);
      i++;
    } else {
      // invalid char
    }
    /* add integer (four utf-8 value) to array */
    if(r4.length > 3) {
      // little endian
      r.push((r4.shift() <<  0) | (r4.shift() <<  8) |
             (r4.shift() << 16) | (r4.shift() << 24));
    }
  }

  return r;
}

/* isaac module pattern */
module.exports = (function() {
  var self = this;

  /* private: internal states */
  var m = Array(256), // internal memory
      acc = 0,        // accumulator
      brs = 0,        // last result
      cnt = 0,        // counter
      r = Array(256), // result array
      gnt = 0;        // generation counter

  /* private: 32-bit integer safe adder */
  function add(x, y) {
    var lsb = (x & 0xffff) + (y & 0xffff);
    var msb = (x >>>   16) + (y >>>   16) + (lsb >>> 16);
    return (msb << 16) | (lsb & 0xffff);
  }

  /* public: initialisation */
  this.reset = function() {
    acc = brs = cnt = 0;
    for(var i = 0; i < 256; ++i)
      m[i] = r[i] = 0;
    gnt = 0;
  }

  /* public: seeding function */
  this.seed = function(s) {
    var a, b, c, d, e, f, g, h, i;

    /* seeding the seeds of love */
    a = b = c = d =
    e = f = g = h = 0x9e3779b9; /* the golden ratio */

    if(s && typeof(s) === 'string')
      s = toIntArray(s);

    if(s && typeof(s) === 'number') {
      s = [s];
    }

    if(s instanceof Array) {
      self.reset();
      for(i = 0; i < s.length; i++)
        r[i & 0xff] += (typeof(s[i]) === 'number') ? s[i] : 0;
    }

    if (s instanceof Uint8Array) {
      self.reset();
      for(i = 0; i < s.length; i++) {
        r[i & 0xff] += s[i];
      }
    }

    /* private: seed mixer */
    function seed_mix() {
      a ^= b <<  11; d = add(d, a); b = add(b, c);
      b ^= c >>>  2; e = add(e, b); c = add(c, d);
      c ^= d <<   8; f = add(f, c); d = add(d, e);
      d ^= e >>> 16; g = add(g, d); e = add(e, f);
      e ^= f <<  10; h = add(h, e); f = add(f, g);
      f ^= g >>>  4; a = add(a, f); g = add(g, h);
      g ^= h <<   8; b = add(b, g); h = add(h, a);
      h ^= a >>>  9; c = add(c, h); a = add(a, b);
    }

    for(i = 0; i < 4; i++) /* scramble it */
      seed_mix();

    for(i = 0; i < 256; i += 8) {
      if(s) { /* use all the information in the seed */
        a = add(a, r[i + 0]); b = add(b, r[i + 1]);
        c = add(c, r[i + 2]); d = add(d, r[i + 3]);
        e = add(e, r[i + 4]); f = add(f, r[i + 5]);
        g = add(g, r[i + 6]); h = add(h, r[i + 7]);
      }
      seed_mix();
      /* fill in m[] with messy stuff */
      m[i + 0] = a; m[i + 1] = b; m[i + 2] = c; m[i + 3] = d;
      m[i + 4] = e; m[i + 5] = f; m[i + 6] = g; m[i + 7] = h;
    }
    if(s) {
      /* do a second pass to make all of the seed affect all of m[] */
      for(i = 0; i < 256; i += 8) {
        a = add(a, m[i + 0]); b = add(b, m[i + 1]);
        c = add(c, m[i + 2]); d = add(d, m[i + 3]);
        e = add(e, m[i + 4]); f = add(f, m[i + 5]);
        g = add(g, m[i + 6]); h = add(h, m[i + 7]);
        seed_mix();
        /* fill in m[] with messy stuff (again) */
        m[i + 0] = a; m[i + 1] = b; m[i + 2] = c; m[i + 3] = d;
        m[i + 4] = e; m[i + 5] = f; m[i + 6] = g; m[i + 7] = h;
      }
    }

    self.prng(); /* fill in the first set of results */
    gnt = 256;  /* prepare to use the first set of results */;
  }

  /* public: isaac generator, n = number of run */
  this.prng = function(n){
    var i, x, y;

    n = (n && typeof(n) === 'number')
      ? Math.abs(Math.floor(n)) : 1;

    while(n--) {
      cnt = add(cnt,   1);
      brs = add(brs, cnt);

      for(i = 0; i < 256; i++) {
        switch(i & 3) {
          case 0: acc ^= acc <<  13; break;
          case 1: acc ^= acc >>>  6; break;
          case 2: acc ^= acc <<   2; break;
          case 3: acc ^= acc >>> 16; break;
        }
        acc        = add(m[(i +  128) & 0xff], acc); x = m[i];
        m[i] =   y = add(m[(x >>>  2) & 0xff], add(acc, brs));
        r[i] = brs = add(m[(y >>> 10) & 0xff], x);
      }
    }
  }

  /* public: return a random number between */
  this.rand = function() {
    if(!gnt--) {
      self.prng(); gnt = 255;
    }
    return r[gnt];
  }

  /* public: return internals in an object*/
  this.internals = function(){
    return {a: acc, b: brs, c: cnt, m: m, r: r};
  }

  this.seed(Math.random() * 0xffffffff);

  /* return class object */
  return {
    'reset': self.reset,
    'seed':  self.seed,
    'prng':  self.prng,
    'rand':  self.rand,
    'internals': self.internals
  };
})();

/* public: output*/
module.exports.random = function() {
  return 0.5 + module.exports.rand() * 2.3283064365386963e-10; // 2^-32
}
