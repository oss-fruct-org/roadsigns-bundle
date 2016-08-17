#!/bin/bash

OUT=$(realpath $1)

mkdir -p build
cd build

git clone https://github.com/oss-fruct-org/graphhopper-priority.git
cd graphhopper-priority
./gradlew jar
cp ./build/libs/graphhopper-priority-1.3.2.jar $OUT/lib
ln -s graphhopper-priority-1.3.2.jar $OUT/lib/graphhopper-priority.jar