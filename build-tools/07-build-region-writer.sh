#!/bin/bash

set -e

OUT=$(realpath $1)

mkdir -p build
cd build
mkdir -p $OUT/plugins

if [ ! -d osmosis-region-writer ]; then
    git clone https://github.com/ivashov/osmosis-region-writer.git
fi
cd osmosis-region-writer
./gradlew fatJar
cp ./build/libs/OsmRegionWriter-with-dependencies-1.0.jar $OUT/plugins
