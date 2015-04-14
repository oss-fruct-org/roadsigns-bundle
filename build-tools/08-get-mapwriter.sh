#!/bin/bash

OUT=$(realpath $1)

mkdir -p $OUT/plugins
wget http://ci.mapsforge.org/job/0.5.1/lastSuccessfulBuild/artifact/mapsforge-map-writer/build/libs/mapsforge-map-writer-0.5.1.jar -O $OUT/plugins/mapsforge-map-writer-0.5.1.jar

