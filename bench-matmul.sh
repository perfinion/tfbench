#!/bin/bash

# system python for optimized TF
OPT_PYTHON=/usr/bin/python3
# venv python for pip TF
BIN_PYTHON=~/code/venv/bintf/bin/python3

DATE=$(date '+%Y-%m-%d-%H%M')


run() {
    outname="times-${DATE}-${3}.csv"

    echo -e "\nTesting ${3}"
    "${1}" matmul_bench.py --device "${2}" --out "${outname}" 2>/dev/null
}

[[ -e /dev/nvidia-uvm ]] && run ${OPT_PYTHON} gpu gpu
run ${OPT_PYTHON} cpu opt
run ${BIN_PYTHON} cpu bin

python graph.py "times-${DATE}" 2>/dev/null
