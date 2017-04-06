#!/bin/bash

set -e

if [ $# -lt 2 ]; then
    echo "Usage: $0 iv string"
    exit 1
fi

IV=${1}
STRING=${2}

printf "%s$s" ${IV} ${STRING} | sha1sum | cut -f1 -d' '
