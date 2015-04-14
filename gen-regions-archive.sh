#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 regions-file polygon-dir target-file"
    exit 1
fi

FILE_REGIONS=${1}
DIR_POLY=${2}
TARGET_FILE=${3}

TMP_DIR=`mktemp -d`

while read line; do
   FILE_POLY=`echo "$line" | cut -f1`
   FILE_OUTPUT=`echo "$line" | cut -f2`
   echo ${FILE_POLY}

   ./poly_ramer_douglas_peucker.py "${DIR_POLY}/${FILE_POLY}" > "$TMP_DIR/$(./create-id.sh rb ${FILE_OUTPUT}).poly" 5000
    
done < ${FILE_REGIONS}

cd "$TMP_DIR"
zip "$TARGET_FILE" *
