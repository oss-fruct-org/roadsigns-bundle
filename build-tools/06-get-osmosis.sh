#!/bin/bash

OUT=$(realpath $1)

mkdir -p build/osmosis
cd build

wget http://bretth.dev.openstreetmap.org/osmosis-build/osmosis-0.43.1.tgz
cd osmosis
tar -xf ../osmosis-0.43.1.tgz
cd ..
mv osmosis $OUT
