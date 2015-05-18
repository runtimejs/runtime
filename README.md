# runtime.js

[![Build Status](https://travis-ci.org/runtimejs/runtime.svg?branch=master)](https://travis-ci.org/runtimejs/runtime) [![npm version](https://badge.fury.io/js/runtimejs.svg)](http://badge.fury.io/js/runtimejs) [![Join the chat at https://gitter.im/runtimejs/runtime](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/runtimejs/runtime?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

__runtime.js__ is a tiny open-source operating system that runs JavaScript, could be bundled up with an application and deployed as a standalone and lightweight VM image.

Example **index.js**:

```js
var runtime = require('runtimejs')
console.log('Hello world!')
```

Let's bundle up and run it!

```bash
# install dependencies
npm install runtimejs
npm install runtimeify -g
npm install runtime-tools -g

# bundle up ramdisk image
runtimeify index.js -o initrd

# make sure you have QEMU installed
brew install qemu           # OSX
sudo apt-get install qemu   # Ubuntu

# run it in QEMU
runtime-qemu ./initrd
```

The system is built on [V8 JavaScript engine](https://code.google.com/p/v8/) and uses event-driven and non-blocking I/O model inspired by [Node.js](https://nodejs.org/).

WARNING: project is in development and not ready for production use. Contributions are welcome.

## How does it work?

There are two main components: operating system (OS) kernel and a <a href="https://www.npmjs.com/package/runtimejs"><nobr>core JavaScript library</nobr></a>.

The kernel is the C++ program that manages low-level resources like CPU and memory, runs applications using embedded <a href="https://code.google.com/p/v8/"><nobr>V8 JavaScript engine</nobr></a>, and exposes raw hardware to JavaScript.

Application, its dependencies and the core library are bundled up using <a href="http://browserify.org/">Browserify</a>, then packed into ramdisk image for kernel to use.



License
----
Apache License, Version 2.0
