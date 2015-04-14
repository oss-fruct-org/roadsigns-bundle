#!/bin/bash
mkdir $1/osmconvert
wget -O - http://m.m.i24.cc/osmconvert.c | gcc -x c - -lz -O3 -o $1/osmconvert/osmconvert
