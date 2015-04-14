#!/bin/bash

mkdir -p build
cd build

wget http://www.slf4j.org/dist/slf4j-1.7.12.tar.gz
tar -xf slf4j-1.7.12.tar.gz 
cp slf4j-1.7.12/slf4j-api-1.7.12.jar $1/lib
cp slf4j-1.7.12/slf4j-simple-1.7.12.jar $1/lib
