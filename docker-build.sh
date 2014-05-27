#!/bin/bash

docker run --rm -w /mnt -v $(pwd):/mnt:rw runtimejs scons
