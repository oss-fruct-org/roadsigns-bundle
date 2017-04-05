#!/bin/bash

set -e

OUT=$(realpath $1)

mkdir -p build
cd build

mkdir -p slf4j
cd slf4j
if [ ! slf4j-1.7.21.tar.gz ]; then
    wget -c http://www.slf4j.org/dist/slf4j-1.7.21.tar.gz
fi
tar -xf slf4j-1.7.21.tar.gz 
cp slf4j-1.7.21/slf4j-api-1.7.21.jar $OUT/lib
cp slf4j-1.7.21/slf4j-simple-1.7.21.jar $OUT/lib
