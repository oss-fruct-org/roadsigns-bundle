#!/bin/bash
OUT=$(realpath $1)

mkdir $OUT/osmconvert
wget -O - http://m.m.i24.cc/osmconvert.c | gcc -x c - -lz -O3 -o $OUT/osmconvert/osmconvert
