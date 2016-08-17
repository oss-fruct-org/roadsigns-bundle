#!/bin/bash

OUT=$(realpath $1)

mkdir -p build/poly
cd build/poly
mkdir -p $OUT/poly

wget -c http://gis-lab.info/data/osm/osm-rus-poly.7z
7z x -y osm-rus-poly.7z
mv poly/* $OUT/poly