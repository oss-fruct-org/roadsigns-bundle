#!/bin/bash

set -e

OUT=$(realpath $1)

mkdir -p $OUT/plugins
if [ ! -f $OUT/plugins/mapsforge-map-writer-0.7.0.jar ]; then
    wget -c "http://search.maven.org/remotecontent?filepath=org/mapsforge/mapsforge-map-writer/0.7.0/mapsforge-map-writer-0.7.0-jar-with-dependencies.jar" -O $OUT/plugins/mapsforge-map-writer-0.7.0.jar
fi

