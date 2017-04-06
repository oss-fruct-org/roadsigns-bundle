#!/bin/bash

set -e

if [ "x$JAVA_HOME" = "x" ]; then
    JAVA=java
else
    JAVA=${JAVA_HOME}/bin/java    
fi

function die {
    echo ${1}
    exit 1
}

if [ $# -lt 3 ]; then
    echo "Usage: $0 source-dir regions-file target-dir"
    exit 1
fi

SOURCE_DIR=${1}
FILE_REGIONS=${2}
TARGET_DIR=${3}

mkdir -p ${TARGET_DIR} || die "Cannot create directory ${TARGET_DIR}"

while read line; do
    FILE_POLY=`echo "$line" | cut -f1`
    FILE_OUTPUT=`echo "$line" | cut -f2`
    DESC=`echo "$line" | cut -f3`

    SOURCE_FILE=${SOURCE_DIR}/${FILE_OUTPUT}.osm.pbf
    TARGET_FILE=${FILE_OUTPUT}.osm.pbf

    osmosis/bin/osmosis --rb ${SOURCE_FILE} --mapfile-writer file="${TARGET_DIR}/${TARGET_FILE}.map" comment="<file><name>${FILE_OUTPUT}.osm.pbf.map</name> <description lang=\"ru\">${DESC}</description><region-id>$(./create-id.sh rb "${FILE_OUTPUT}")</region-id> </file>"

    echo "<file><name>${FILE_OUTPUT}.osm.pbf.map</name> <description lang=\"ru\">${DESC}</description> </file>"
done < ${FILE_REGIONS}
