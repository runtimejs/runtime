# runtime.js

[![Build Status](https://travis-ci.org/runtimejs/runtime.svg?branch=master)](https://travis-ci.org/runtimejs/runtime) [![npm](https://img.shields.io/npm/v/runtimejs.svg)](https://www.npmjs.com/package/runtimejs) [![Gem](https://img.shields.io/badge/freenode-%23runtimejs-blue.svg)](https://freenode.net/) [![Travis](https://img.shields.io/badge/GITTER-JOIN_CHAT_%E2%86%92-1dce73.svg)](https://gitter.im/runtimejs/runtime)

__runtime.js__ is an open-source library operating system (unikernel) for the cloud that runs JavaScript, can be bundled up with an application and deployed as a lightweight and immutable VM image. 

It's built on [V8 JavaScript engine](https://code.google.com/p/v8/) and uses event-driven and non-blocking I/O model inspired by [Node.js](https://nodejs.org/). At the moment [KVM](http://www.linux-kvm.org/page/Main_Page) is the only supported hypervisor.

It tries to be compatible with npm module ecosystem and supports some of the Node.js API.

_WARNING: project is in development and not ready for production use._

### Installation

First thing is the command line tool `runtime-cli`, it will add `runtime` command to the shell. Type `runtime` to get full usage help.

```
npm install runtime-cli -g
```

Make sure QEMU is installed, it enables running applications locally.

```
brew install qemu           # OSX
sudo apt-get install qemu   # Ubuntu
```

### Getting Started

Create new project and add `index.js` entry point file:

```
mkdir project
cd project
npm init
npm install runtimejs --save
echo "console.log('ok')" > index.js
```

Run project locally in QEMU:

```
runtime start
```

That's it, it should start and print `ok` in the console. 

Optionally you can let it watch directory for changes and restart QEMU automatically:

```
runtime watch
```

## How does it work?

There are two main components: operating system kernel and a <a href="https://www.npmjs.com/package/runtimejs"><nobr>JavaScript library</nobr></a>.

The kernel is written in C++ and manages low-level resources like CPU and memory, runs JavaScript using embedded V8 engine. Library drives the entire system and manages hardware devices (usually virtualized by hypervisor).

## Docs

[API docs](https://github.com/runtimejs/runtime/wiki/API-docs)

## Community

[Modules and projects developed by the community for runtime.js](https://github.com/runtimejs/runtime/wiki/Community)

License
----
Apache License, Version 2.0
