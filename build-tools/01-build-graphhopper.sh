#!/bin/bash

mkdir -p build
cd build

git clone --depth=1 -b 0.4 https://github.com/graphhopper/graphhopper.git
cd graphhopper
./graphhopper.sh build
cp ./core/target/graphhopper-0.4.1.jar $1/lib
