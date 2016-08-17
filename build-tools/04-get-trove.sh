#!/bin/bash

OUT=$(realpath $1)

mkdir -p build
cd build

mkdir trove
cd trove
wget -c https://bitbucket.org/trove4j/trove/downloads/trove-3.0.3.tar.gz
tar -xf trove-3.0.3.tar.gz
cd 3.0.3
cp ./lib/trove-3.0.3.jar $OUT/lib
