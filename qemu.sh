#!/bin/bash

qemu-system-x86_64                                          \
    -m 512                                                  \
    -smp 1                                                  \
    -s                                                      \
    -kernel disk/boot/runtime                               \
    -initrd disk/boot/initrd                                \
    -serial stdio
