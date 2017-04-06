#!/bin/bash

set -e

if [ $# -lt 2 ]; then
    echo "Usage: $0 input-dir epsilon-meters"
    exit 1
fi

INPUT_DIR="$1"
EPSILON="$2"

shopt -s nullglob
for f in $INPUT_DIR/*.poly
do
    ./poly_ramer_douglas_peucker.py "$f" $EPSILON > /tmp/out.poly
    mv /tmp/out.poly $f
done
shopt -u nullglob
