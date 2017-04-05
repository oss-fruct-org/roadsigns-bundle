#!/bin/bash

set -e

mkdir -p ../lib ../osmconvert ../plugins ../poly
echo ==== ./01-build-graphhopper.sh ..
#./01-build-graphhopper.sh ..
echo === ./02-build-graphhopper-priority.sh ..
#./02-build-graphhopper-priority.sh ..
echo === ./03-get-slf4j.sh ..
#./03-get-slf4j.sh ..
echo === ./04-get-trove.sh ..
#./04-get-trove.sh ..
echo === ./05-build-osmconvert.sh ..
#./05-build-osmconvert.sh ..
echo === ./06-get-osmosis.sh ..
./06-get-osmosis.sh ..
echo === ./07-build-region-writer.sh ..
./07-build-region-writer.sh ..
echo === ./08-get-mapwriter.sh ..
./08-get-mapwriter.sh ..
echo === ./09-get-poly.sh ..
./09-get-poly.sh ..
