#!/bin/bash
set -e

if [ $# -ne 2 ]; then
    echo "expected 2 parameters: install_location dela_tar"
    exit 1
fi

if [ ! -d "$1" ]; then
	mkdir -p $1
fi 
INSTALL_DIR=`cd $1; pwd`
echo $INSTALL_DIR

TAR=$2
echo $TAR

tar -xzvf $TAR -C $INSTALL_DIR
cd $INSTALL_DIR
echo "">> conf/application.conf
echo "webservice.server=\"`pwd`/conf/config.yml\"" >> conf/application.conf