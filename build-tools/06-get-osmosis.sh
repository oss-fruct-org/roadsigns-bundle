#!/bin/bash

mkdir -p build/osmosis
cd osmosis

wget http://bretth.dev.openstreetmap.org/osmosis-build/osmosis-0.43.1.tgz
cd osmosis
tar -xf osmosis-0.43.1.tgz
cd ..
mv osmosis $1
