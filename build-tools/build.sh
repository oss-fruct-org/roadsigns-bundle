#!/bin/bash

mkdir -p ../lib ../osmconvert ../plugins
./01-build-graphhopper.sh ..
./02-build-graphhopper-priority.sh ..
./03-get-slf4j.sh ..
./04-get-trove.sh ..
./05-build-osmconvert.sh ..
./06-get-osmosis.sh ..
./07-build-region-writer.sh ..
./08-get-mapwriter.sh ..
