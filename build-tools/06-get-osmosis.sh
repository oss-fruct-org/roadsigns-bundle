#!/bin/bash

OUT=$(realpath $1)

mkdir -p build/osmosis
cd build

wget -c http://bretth.dev.openstreetmap.org/osmosis-build/osmosis-latest.tgz
cd osmosis
tar -xf ../osmosis-latest.tgz
cd ..
mv osmosis $OUT
