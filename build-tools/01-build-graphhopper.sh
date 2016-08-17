#!/bin/bash

OUT=$(realpath $1)

mkdir -p build
cd build

git clone --depth=1 -b 0.7.0 https://github.com/graphhopper/graphhopper.git
cd graphhopper
git apply <../../graphhopper.patch
./graphhopper.sh build
cp ./core/target/graphhopper-0.7.0-jar-with-dependencies.jar $OUT/lib
ln -s graphhopper-0.7.0-jar-with-dependencies.jar $OUT/lib/graphhopper.jar
