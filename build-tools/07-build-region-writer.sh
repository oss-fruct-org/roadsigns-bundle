#!/bin/bash

OUT=$(realpath $1)

mkdir -p build
cd build
mkdir -p $OUT/plugins

git clone https://github.com/ivashov/osmosis-region-writer.git
cd osmosis-region-writer
./gradlew fatJar
cp ./build/libs/OsmRegionWriter-with-dependencies-1.0.jar $OUT/plugins
