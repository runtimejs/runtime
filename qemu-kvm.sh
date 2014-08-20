#!/bin/bash

qemu-system-x86_64                                          \
    -m 512                                                  \
    -smp 1                                                  \
    -s                                                      \
    -enable-kvm                                             \
    -no-kvm-irqchip                                         \
    -kernel disk/boot/kernel.bin                            \
    -initrd disk/boot/initrd                                \
    -serial stdio
