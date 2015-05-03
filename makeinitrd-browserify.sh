#!/bin/bash

browserify js > build/system/kernel.js && ./mkinitrd -c disk/boot/initrd build
