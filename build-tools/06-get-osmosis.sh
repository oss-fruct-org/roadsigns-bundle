#!/bin/bash

set -e

OUT=$(realpath $1)

mkdir -p build/osmosis
cd build

if [ ! -f osmosis-latest.tgz ]; then
    wget -c http://bretth.dev.openstreetmap.org/osmosis-build/osmosis-latest.tgz
fi
cd osmosis
tar -xf ../osmosis-latest.tgz
cd ..
cp -r osmosis $OUT
