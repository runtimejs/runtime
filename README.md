Runtime.JS [![Build Status](https://travis-ci.org/runtimejs/runtime.svg?branch=master)](https://travis-ci.org/runtimejs/runtime)
====

__Runtime.JS__ is a kernel built on V8 JavaScript engine. It uses event-driven and non-blocking I/O model inspired by Node.js.

The goal of this project is to design and implement a kernel that is optimized to run JavaScript applications. By providing environment for JavaScript code only, it is possible to rethink kernel design to improve security, reliability and performance of the system. 

It's currently under development and does not include many essential features. If you want to contribute, your help is very welcome.

You can use issues section to ask any questions or share your ideas https://github.com/runtimejs/runtime/issues

Project random discussions here https://github.com/runtimejs/discussions/issues

Join IRC chatroom #runtimejs on freenode

![Console](https://raw.githubusercontent.com/runtimejs/runtimejs.github.io/master/img/runtimejs_3.png)


Technical details
----

Kernel architecture http://runtimejs.org/docs/arch.html

- supported x86_64, 64 bit only
- software isolated applications (isolates)
- single address space, no hardware context switches
- does not use cpu protection rings
- non-blocking asynchronous IPC
- drivers and system services are implemented in JavaScript
- low-level kernel services are written in C++11

Status
----

####What's done

- embedded V8 engine
- multitasking (cooperative only)
- [RPC](https://github.com/runtimejs/runtime/wiki/RPC)
- SMP support (currently disabled)
- embedded ACPICA for ACPI support
- simple keyboard and VGA display drivers
- JavaScript REPL application
- PCI bus driver device detection
- simple virtio-net driver


####Planned

- network stack
- virtual file system
- virtio drivers for storage and network


Build
----
####Prerequisites
- gcc 4.8 or newer cross compiler (target x86\_64-elf)
- fasm
- scons

####Using Docker

Easiest way to setup developer environment is to use Docker https://www.docker.io/

    ./docker-prepare.sh

To build

    ./docker-build.sh

####Without Docker

You need to install fasm, scons and GCC cross compiler targeting x86\_64-elf. http://wiki.osdev.org/GCC_Cross-Compiler

To build

    scons
    
####Run using QEMU

    ./qemu.sh
    
####Try prebuilt binaries in QEMU

Download latest __runtime__ and __initrd__ files from releases page https://github.com/runtimejs/runtime/releases

Run
```bash
qemu-system-x86_64                                \
    -m 512                                        \
    -smp 1                                        \
    -kernel runtime                               \
    -initrd initrd                                \
    -serial stdio
```
    
License
----
Apache License, Version 2.0
