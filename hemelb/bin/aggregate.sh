#!/bin/bash

if [[ $# != 1 ]]; then
        echo "usage: $0 <output-dir>"
        exit -1
fi

OUTPUT_DIR="$1"

module purge
module add anaconda3/5.1.0-gcc/8.3.1

source activate mlbd

python bin/aggregate.py \
    --conditions ${OUTPUT_DIR}/conditions.txt \
    --trace-input ${OUTPUT_DIR}/reports/trace.txt \
    --trace-output ${OUTPUT_DIR}/trace.txt \
    --fix-exit-na -1 \
    --fix-runtime-ms
