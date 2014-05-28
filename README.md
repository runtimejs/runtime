runtime.js
====

Inspired by Node.js event-driven architecture and non-blocking I/O model, runtime.js kernel provides a platform that is specifically designed to run JavaScript applications.

Project is under development and currently does not provide many essential features. If you want to contribute, your help is very welcome.

Technical details
----

- supported x86_64 only
- software isolated applications (processes)
- no heavy context switches, single address space
- does not use cpu protection rings
- non-blocking asynchronous IPC
- drivers and system services are separate applications
- kernel written in C++11

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
    
