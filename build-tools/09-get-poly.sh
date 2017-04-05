#!/bin/bash

set -e

OUT=$(realpath $1)

# проверка наличия необходимого ПО
7z --help >/dev/null

mkdir -p build/poly
cd build/poly
mkdir -p $OUT/poly

wget -c http://gis-lab.info/data/osm/osm-rus-poly.7z
7z x -y osm-rus-poly.7z
mv -f poly/* $OUT/poly
