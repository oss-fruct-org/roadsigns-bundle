#!/bin/bash

mkdir -p build
cd build
mkdir -p $1/plugins

git clone https://github.com/ivashov/osmosis-region-writer.git
cd osmosis-region-writer
./gradlew jar
cp ./build/libs/OsmRegionWriter-1.0.jar $1/plugins
