#!/bin/bash

set -e

OUT=$(realpath $1)

mkdir -p build
cd build

if [ ! -d graphhopper-priority ]; then
    git clone https://github.com/oss-fruct-org/graphhopper-priority.git
fi
cd graphhopper-priority
./gradlew jar
cp ./build/libs/graphhopper-priority-1.3.2.jar $OUT/lib
if [ ! -f $OUT/lib/graphhopper-priority.jar ]; then
    ln -s graphhopper-priority-1.3.2.jar $OUT/lib/graphhopper-priority.jar
fi