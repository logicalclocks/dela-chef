#!/bin/bash
set -e

if [ $# -ne 1 ]; then
    echo "expected 1 parameter: base_build_dir"
    exit 1
fi

export MAVEN_OPTS="-Xmx512m"
BASE_DIR=`cd $1; pwd`
echo "base dir: $BASE_DIR"

#legacy dependency
CARACAL_REPO="https://github.com/CaracalDB/CaracalDB.git"
CARACAL_BRANCH="vod"
#
KAFKA_UTIL_REPO="https://github.com/hopshadoop/kafka-util.git"
KAFKA_BRANCH="hops-v1.9"
#
KTOOLBOX_REPO="https://github.com/Decentrify/KompicsToolbox.git"
KTOOLBOX_BRANCH="storage"
#
NATTRAVERSAL_REPO="https://github.com/Decentrify/NatTraversal.git"
NATTRAVERSAL_BRANCH="hops-v1.9"
#
GVOD_REPO="https://github.com/Decentrify/GVoD.git"
GVOD_BRANCH="storage"
#
DOZY_REPO="https://github.com/Decentrify/Dozy.git"
DOZY_BRANCH="storage"
DOZY_VERSION="0.0.1-SNAPSHOT"

LOG="build.log"

cd $BASE_DIR
rm -rf build
mkdir build
cd build
touch $LOG

#CARACAL
cd $BASE_DIR/build
echo "cloning caracaldb.."
git clone --progress $CARACAL_REPO caracaldb >>./$LOG  2>&1
cd caracaldb
git checkout --progress $CARACAL_BRANCH >>../$LOG  2>&1
echo "building caracaldb.."
mvn clean install -DskipTests >>../$LOG  2>&1
#KAFKA
cd $BASE_DIR/build
echo "cloning kafka-util.."
git clone --progress $KAFKA_UTIL_REPO kafka-util >>$LOG  2>&1
cd kafka-util
git checkout --progress $KAFKA_BRANCH >>../$LOG  2>&1
echo "building kafka-util.."
mvn clean install -DskipTests >>../$LOG  2>&1
#KAFKA
cd $BASE_DIR/build
echo "cloning ktoolbox.."
git clone --progress $KTOOLBOX_REPO ktoolbox >>$LOG  2>&1
cd ktoolbox
git checkout --progress $KTOOLBOX_BRANCH >>../$LOG  2>&1
echo "building ktoolbox.."
mvn clean install -DskipTests >>../$LOG  2>&1
#NATTRAVERSAL
cd $BASE_DIR/build
echo "cloning nattraversal.."
git clone --progress $NATTRAVERSAL_REPO nat-traversal >>$LOG  2>&1
cd nat-traversal
git checkout --progress $NATTRAVERSAL_BRANCH >>../$LOG  2>&1
echo "building nattraversal.."
mvn clean install -DskipTests >>../$LOG  2>&1
#GVOD
cd $BASE_DIR/build
echo "cloning gvod.."
git clone --progress $GVOD_REPO gvod >>$LOG  2>&1
cd gvod
git checkout --progress $GVOD_BRANCH >>../$LOG  2>&1
echo "building gvod.."
mvn clean install -DskipTests >>../$LOG  2>&1
#DOZY
cd $BASE_DIR/build
echo "cloning dozy.."
git clone --progress $DOZY_REPO dozy >>$LOG  2>&1
cd dozy
git checkout --progress $DOZY_BRANCH >>../$LOG  2>&1
echo "building dozy.."
mvn clean install -DskipTests >>../$LOG  2>&1
#final fat jar
VERSION=`grep -o -a -m 1 -h -r "version>.*</version" pom.xml | head -1 | sed "s/version//g" | sed "s/>//" | sed "s/<\///g"`
echo "version is: $VERSION"
#DELA
cd $BASE_DIR/build
mkdir dela
cd dela
touch .version
echo $VERSION > .version
echo "final jar:`pwd`/dela-${VERSION}.jar"
mkdir lib
cp ${BASE_DIR}/build/dozy/vod-system/target/vod-system-${VERSION}-dozy.jar lib/dela-${VERSION}.jar
mkdir conf
cp ${BASE_DIR}/build/dozy/vod-system/src/main/resources/default_config.yml conf/config.yml
cp ${BASE_DIR}/build/dozy/vod-system/src/main/resources/default_application.conf conf/application.conf
cp -r ${BASE_DIR}/scripts/bin ./

echo "done"