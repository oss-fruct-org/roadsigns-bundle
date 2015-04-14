#!/bin/bash

GH_LIB="lib/graphhopper-0.4-SNAPSHOT-jar-with-dependencies.jar"
GH_CLASS="com.graphhopper.GraphHopper"
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
    echo "Usage: $0 map-dir regions-file http-prefix"
    exit 1
fi

DIR_MAP=${1}
FILE_REGIONS=${2}
PREFIX="${3}"

echo "<content>"
while read line; do
    FILE_OUTPUT=`echo "$line" | cut -f2`
    DESC=`echo "$line" | cut -f3`

    TARGET_FILE=${DIR_MAP}/${FILE_OUTPUT}.osm.pbf

    if [ -f "${TARGET_FILE}.map" ]; then
        UHASH=$(sha1sum "${TARGET_FILE}.map" | awk '{print $1}')
        USIZE=$(wc -c "${TARGET_FILE}.map" | awk '{print $1}')
        gzip -9 "${TARGET_FILE}.map"
        CSIZE=$(wc -c "${TARGET_FILE}.map.gz" | awk '{print $1}')

        cat << EOF
    <file>
        <type>mapsforge-map</type>
        <name>${FILE_OUTPUT}.osm.pbf.map</name>
        <description>${DESC}</description>
        <size>${USIZE}</size>
        <url compression="gzip" size="${CSIZE}">${PREFIX}${FILE_OUTPUT}.osm.pbf.map.gz</url>
        <hash algo="sha1">${UHASH}</hash>
        <region-id>$(./create-id.sh rb "${FILE_OUTPUT}")</region-id>
    </file>
EOF
    fi

    if [ -f "${TARGET_FILE}.ghz" ]; then

        GHSIZE=$(wc -c "${TARGET_FILE}.ghz" | awk '{print $1}')
        GHHASH=$(sha1sum "${TARGET_FILE}.ghz" | awk '{print $1}')

        cat << EOF
    <file>
        <type>graphhopper-map</type>
        <name>${FILE_OUTPUT}.osm.pbf.ghz</name>
        <description>${DESC}</description>
        <size>${GHSIZE}</size>
        <url>${PREFIX}${FILE_OUTPUT}.osm.pbf.ghz</url>
        <hash algo="sha1">${GHHASH}</hash>
        <region-id>$(./create-id.sh rb "${FILE_OUTPUT}")</region-id>
    </file>
EOF
    fi
done < ${FILE_REGIONS}

echo "</content>"
