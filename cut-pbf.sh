#!/bin/bash

set -e

function die {
    echo ${1}
    exit 1
}

if [ $# -lt 4 ]; then
    echo "Usage: $0 pbf-file regions-file polygon-dir output-dir"
    exit 1
fi

FILE_PBF=${1}
FILE_REGIONS=${2}
DIR_POLY=${3}
DIR_OUTPUT=${4}

N=$(cat ${FILE_REGIONS} | wc -l)

echo xargs osmosis/bin/osmosis --rb ${FILE_PBF} --tee ${N}

while read line; do 
   FILE_POLY=`echo "$line" | cut -f1`  
   FILE_OUTPUT=`echo "$line" | cut -f2` 
   echo --bounding-polygon file=${DIR_POLY}/${FILE_POLY}
   echo completeWays=yes
   echo --wb file=${DIR_OUTPUT}/${FILE_OUTPUT}.osm.pbf
done < ${FILE_REGIONS} | xargs osmosis/bin/osmosis --rb ${FILE_PBF} --tee ${N}
