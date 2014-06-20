Runtime.JS [![Build Status](https://travis-ci.org/runtimejs/runtime.svg?branch=master)](https://travis-ci.org/runtimejs/runtime)
====

__Runtime.JS__ is a kernel built on V8 JavaScript engine. It uses event-driven and non-blocking I/O model inspired by Node.js.

This is an experimental project to design and implement a kernel that is optimized to run JavaScript applications. It's currently under development and does not include many essential features. If you want to contribute, your help is very welcome.

You can use mailing list to ask any questions or share your ideas https://groups.google.com/group/runtimejs

![Console](https://raw.githubusercontent.com/runtimejs/runtimejs.github.io/master/img/runtimejs_2.png)

Technical details
----

- supported x86_64 only
- software isolated applications (processes)
- no heavy context switches, single address space
- does not use cpu protection rings
- non-blocking asynchronous IPC
- drivers and system services are implemented in JavaScript
- kernel written in C++11

Status
----

####What's done

- embedded V8 engine
- multitasking (cooperative only)
- IPC transferable functions and ArrayBuffers
- SMP support
- embedded ACPICA for ACPI support
- simple keyboard and VGA display drivers
- JavaScript REPL application
- PCI bus driver device detection


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

Download latest __kernel.bin__ and __initrd__ files from releases page https://github.com/runtimejs/runtime/releases

Run
```
qemu-system-x86_64                                \
    -m 512                                        \
    -smp 2                                        \
    -kernel kernel.bin                            \
    -initrd initrd                                \
    -serial stdio
```
    
License
----
Apache License, Version 2.0
