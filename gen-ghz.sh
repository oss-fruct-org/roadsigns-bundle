#!/bin/bash

GH_LIB="lib/*:osmosis/lib/default/*"
GH_CLASS="org.fruct.oss.ghpriority.Main"
if [ "x$JAVA_HOME" = "x" ]; then
    JAVA=java
else
    JAVA=${JAVA_HOME}/bin/java    
fi

function die {
    echo ${1}
    exit 1
}

if [ $# -lt 4 ]; then
    echo "Usage: $0 source-dir polygon-dir regions-file target-dir"
    exit 1
fi

SOURCE_DIR=${1}
POLYGON_DIR=${2}
FILE_REGIONS=${3}
TARGET_DIR=${4}

mkdir -p ${TARGET_DIR} || die "Cannot create directory ${TARGET_DIR}"

while read line; do
    FILE_POLY=`echo "$line" | cut -f1`
    FILE_OUTPUT=`echo "$line" | cut -f2`
    DESC=`echo "$line" | cut -f3`

    SOURCE_FILE=${SOURCE_DIR}/${FILE_OUTPUT}.osm.pbf
    TARGET_FILE=${FILE_OUTPUT}.osm.pbf
    ${JAVA} ${JAVACMD_OPTIONS} -cp "${GH_LIB}" ${GH_CLASS} config=config.properties graph.location=${TARGET_DIR} osmreader.osm="$SOURCE_FILE"
    cp ${POLYGON_DIR}/${FILE_POLY} ${TARGET_DIR}/polygon.poly

    cat << EOF > ${TARGET_DIR}/description.txt
<file>
    <region-id>$(./create-id.sh rb "${FILE_OUTPUT}")</region-id>
    <name>${FILE_OUTPUT}.osm.pbf.ghz</name>
    <description lang="ru">${DESC}</description>
</file>
EOF
    pushd ${TARGET_DIR}
    zip ${TARGET_FILE}.ghz description.txt polygon.poly edges geometry location_index names nodes properties
    rm description.txt polygon.poly edges geometry location_index names nodes properties
    popd
done < ${FILE_REGIONS}
