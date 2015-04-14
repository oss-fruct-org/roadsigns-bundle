#!/bin/bash

mkdir -p $1/plugins
wget http://ci.mapsforge.org/job/0.5.1/lastSuccessfulBuild/artifact/mapsforge-map-writer/build/libs/mapsforge-map-writer-0.5.1.jar -O $1/plugins/mapsforge-map-writer-0.5.1.jar

