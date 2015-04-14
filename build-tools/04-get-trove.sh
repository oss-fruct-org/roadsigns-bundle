#!/bin/bash
mkdir build
cd build

wget https://bitbucket.org/robeden/trove/downloads/trove-3.0.3.tar.gz
tar -xf trove-3.0.3.tar.gz
cd 3.0.3
cp ./lib/trove-3.0.3.jar $1/lib
