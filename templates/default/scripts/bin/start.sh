#!/bin/bash
set -e
if [ $# -ne 1 ]; then
    echo "expected 1 parameter: base_install_dir"
    exit 1
fi

BASE_DIR=`cd $1; pwd`
echo "base dir: $BASE_DIR"
VERSION=`cat $BASE_DIR/.version`
CONF="-Dconfig.file=${BASE_DIR}/conf/application.conf"
IPV4="-Djava.net.preferIPv4Stack=true"
JAR="${BASE_DIR}/lib/dela-${VERSION}.jar"

cd $BASE_DIR
rm -f nohup.out dela.pid dozy.log*
echo "nohup java $IPV4 $CONF -jar $JAR &> nohup.out &"
nohup java $IPV4 $CONF -jar $JAR &> nohup.out &
echo $! > dela.pid
