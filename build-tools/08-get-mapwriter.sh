#!/bin/bash

OUT=$(realpath $1)

mkdir -p $OUT/plugins
wget http://ci.mapsforge.org/job/0.6.1/lastSuccessfulBuild/artifact/mapsforge-map-writer/build/libs/mapsforge-map-writer-0.6.1-jar-with-dependencies.jar -O $OUT/plugins/mapsforge-map-writer-0.6.1.jar

