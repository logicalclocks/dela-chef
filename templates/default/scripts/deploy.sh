#!/bin/bash
set -e
if [ $# -ne 1 ]; then
    echo "expected 1 parameter: base_build_dir"
    exit 1
fi

BASE_DIR=`cd $1; pwd`
echo "base dir: $BASE_DIR"

VERSION=`cat ${BASE_DIR}/build/dela/.version`
JAR=dela-${VERSION}.jar
TAR=dela-${VERSION}.tar.gz
USER="glassfish"
DEPLOY_LOC="snurran.sics.se"
DEPLOY_DIR="/var/www/hops/dela"
LOG="deploy.log"

echo "archiving dela"
cd ${BASE_DIR}/build/dela
touch $LOG
tar -czvf $TAR .version bin lib conf>> $LOG 2>&1
echo "deploying ${TAR} to ${DEPLOY_LOC}:${DEPLOY_DIR} as user:${USER}"
scp ${TAR} ${USER}@${DEPLOY_LOC}:${DEPLOY_DIR}