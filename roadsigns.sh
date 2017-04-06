#!/bin/bash

set -e

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
    echo "Usage: $0 source-file target-dir description"
    exit 1
fi

SOURCE_FILE=${1}
TARGET_DIR=${2}
TARGET_FILE="$(basename ${1})"
DESC=${3}

mkdir -p ${TARGET_DIR} || die "Cannot create directory ${TARGET_DIR}"

${JAVA} -cp ${GH_LIB} ${GH_CLASS} config=config.properties graph.location=${TARGET_DIR} osmreader.osm="${SOURCE_FILE}"

pushd ${TARGET_DIR}
zip ${TARGET_FILE}.ghz edges geometry locationIndex names nodes properties
rm edges geometry locationIndex names nodes properties
popd

#${JAVA} -cp ${GH_LIB} ${GH_CLASS} config=config-quadtree.properties graph.location=${TARGET_DIR} osmreader.osm="${SOURCE_FILE}"
#pushd ${TARGET_DIR}
#zip ${TARGET_FILE}.ghz loc2idIndex
#rm edges geometry names nodes properties loc2idIndex
#popd

JAVACMD_OPTIONS="-Xmx1500m" osmosis/bin/osmosis --rb ${SOURCE_FILE} --mapfile-writer file="${TARGET_DIR}/${TARGET_FILE}.map"

pushd ${TARGET_DIR}

UHASH=$(sha1sum "${TARGET_FILE}.map" | awk '{print $1}')
USIZE=$(wc -c "${TARGET_FILE}.map" | awk '{print $1}')
gzip -9 "${TARGET_FILE}.map"
CSIZE=$(wc -c "${TARGET_FILE}.map.gz" | awk '{print $1}')

GHSIZE=$(wc -c "${TARGET_FILE}.ghz" | awk '{print $1}')
GHHASH=$(sha1sum "${TARGET_FILE}.ghz" | awk '{print $1}')

cat << EOF > "${TARGET_FILE}.xml"
<content>
    <file>
        <type>mapsforge-map</type>
        <name>${TARGET_FILE}.map.gz</name>
        <description>${DESC}</description>
        <size>${USIZE}</size>
        <url compression="gzip" size="${CSIZE}"></url>
        <hash algo="sha1">${UHASH}</hash>
    </file>

    <file>
        <type>graphhopper-map</type>
        <name>${TARGET_FILE}.ghz</name>
        <description>${DESC}</description>
        <size>${GHSIZE}</size>
        <url></url>
        <hash algo="sha1">${GHHASH}</hash>
    </file>
</content>
EOF

popd
