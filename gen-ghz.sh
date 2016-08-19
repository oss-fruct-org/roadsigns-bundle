#!/bin/bash

GH_LIB="lib/*:osmosis/lib/default/*"
if [ "x$JAVA_HOME" = "x" ]; then
    JAVA=java
else
    JAVA=${JAVA_HOME}/bin/java    
fi

function die {
    echo ${1}
    exit 1
}

if [ $# -lt 5 ]; then
    echo "Usage: $0 source-dir polygon-dir regions-file main-GH-class target-dir"
    exit 1
fi

SOURCE_DIR=$(realpath ${1})
POLYGON_DIR=$(realpath ${2})
FILE_REGIONS=$(realpath ${3})
GH_CLASS=${4}
TARGET_DIR=$(realpath ${5})

mkdir -p ${TARGET_DIR} || die "Cannot create directory ${TARGET_DIR}"

while read line; do
    FILE_POLY=`echo "$line" | cut -f1`
    FILE_OUTPUT=`echo "$line" | cut -f2`
    DESC=`echo "$line" | cut -f3`

    SOURCE_FILE="${SOURCE_DIR}/${FILE_OUTPUT}.osm.pbf"
    TARGET_FILE="${TARGET_DIR}/${FILE_OUTPUT}.osm.pbf.ghz"

    OUTPUT_DIR="${TARGET_DIR}/out"
    mkdir -p ${OUTPUT_DIR}

    ${JAVA} ${JAVACMD_OPTIONS} -cp "${GH_LIB}" ${GH_CLASS} config=config.properties \
        graph.location="${OUTPUT_DIR}" osmreader.osm="$SOURCE_FILE"

    cp "${POLYGON_DIR}/${FILE_POLY}" "${OUTPUT_DIR}/polygon.poly"

    mkdir -p "${OUTPUT_DIR}/regions6"
    osmosis/bin/osmosis --rb "$SOURCE_FILE" --wrd file="${OUTPUT_DIR}/regions6"
    ./rdp-poly.sh "${OUTPUT_DIR}/regions6" 1000

    cat << EOF > ${OUTPUT_DIR}/description.txt
<file>
    <region-id>$(./create-id.sh rb "${FILE_OUTPUT}")</region-id>
    <name>${FILE_OUTPUT}.osm.pbf.ghz</name>
    <description lang="ru">${DESC}</description>
</file>
EOF
    pushd "${OUTPUT_DIR}"
    zip -r "${TARGET_FILE}" description.txt polygon.poly edges geometry location_index names nodes properties regions6
    popd
    
    pushd "${TARGET_DIR}"
    rm -rv out
    popd
done < "${FILE_REGIONS}"
