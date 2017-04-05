#!/bin/bash

set -e

OUT=$(realpath $1)

# проверка наличия gcc и zlib
gcc --version >/dev/null
pkg-config --exists zlib

# компиляция
mkdir -p $OUT/osmconvert
wget -O - http://m.m.i24.cc/osmconvert.c | gcc -x c - -lz -O3 -o $OUT/osmconvert/osmconvert
