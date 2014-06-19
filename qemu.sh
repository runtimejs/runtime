#!/bin/bash

qemu-system-x86_64                                          \
    -m 512                                                  \
    -smp 1                                                  \
    -s                                                      \
    -boot order=d                                           \
    -netdev user,id=mynet0,hostfwd=tcp::5555-:80            \
    -device rtl8139,netdev=mynet0,mac=1a:46:0b:ca:bc:7c     \
    -kernel disk/boot/kernel.bin                            \
    -initrd disk/boot/initrd                                \
    -serial stdio                                           \
    -localtime                                              \
    -M pc
