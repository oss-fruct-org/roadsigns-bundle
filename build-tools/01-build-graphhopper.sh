#!/bin/bash

set -e

OUT=$(realpath $1)

mkdir -p build
cd build

if [ ! -d graphhopper ]; then
    git clone --depth=1 -b 0.7.0 https://github.com/graphhopper/graphhopper.git
    cd graphhopper
    git apply <../../graphhopper.patch
else
    cd graphhopper
fi
./graphhopper.sh build
cp ./core/target/graphhopper-0.7.0-jar-with-dependencies.jar $OUT/lib
rm -f $OUT/lib/graphhopper.jar
ln -s graphhopper-0.7.0-jar-with-dependencies.jar $OUT/lib/graphhopper.jar
