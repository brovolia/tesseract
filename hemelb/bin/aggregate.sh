#!/bin/bash

OUTPUT_DIR="hemelb/output-large"

module purge
module add anaconda3/5.1.0-gcc/8.3.1

source activate mlbd

python bin/aggregate.py \
    --conditions ${OUTPUT_DIR}/conditions.txt \
    --trace-input ${OUTPUT_DIR}/reports/trace.txt \
    --trace-output ${OUTPUT_DIR}/trace.txt \
    --fix-runtime-ms