#!/bin/bash

docker run -w /mnt -v $(pwd):/mnt:rw runtimejs scons
