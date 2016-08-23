#!/bin/bash
set -e
if [ $# -ne 1 ]; then
    echo "expected 1 parameter: base_install_dir"
    exit 1
fi

BASE_DIR=`cd $1; pwd`
echo "base dir: $BASE_DIR"

if [ ! -f "${BASE_DIR}/dela.pid" ]; then
	echo "no pid found for dela"
	exit 1
fi
PID=`cat ${BASE_DIR}/dela.pid`
echo "killing $PID"
kill $PID