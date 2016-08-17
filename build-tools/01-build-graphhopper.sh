#!/bin/bash

OUT=$(realpath $1)

mkdir -p build
cd build

git clone --depth=1 -b 0.7.0 https://github.com/graphhopper/graphhopper.git
cd graphhopper
./graphhopper.sh build
cp ./core/target/graphhopper-0.7.0.jar $OUT/lib
ln -s graphhopper-0.7.0.jar $OUT/lib/graphhopper.jar
