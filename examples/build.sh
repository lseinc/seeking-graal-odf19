#!/bin/bash
DIR=`dirname $0`
DIR=`cd $DIR; pwd`

set -x
cd $DIR

TMP=$DIR/tmp
ETC=$DIR/etc

mkdir -p $TMP

export GRAALVM_VERSION=19.0.2
export GRAALVM_NAME=graalvm-ce-${GRAALVM_VERSION}
export GRAALVM_BINARY=graalvm-ce-linux-amd64-${GRAALVM_VERSION}.tar.gz
export GRAALVM_HOME=/opt/${GRAALVM_NAME}
export GRADLE_VERSION=5.6.3
export GRADLE_BINARY=gradle-${GRADLE_VERSION}-bin.zip

export DEMO=graalvm-demo
export GVM_DEMO=graalvm-demo:0.07

[ ! -f "$TMP/$GRAALVM_BINARY" ] && curl -v -L -o $TMP/$GRAALVM_BINARY https://github.com/oracle/graal/releases/download/vm-${GRAALVM_VERSION}/${GRAALVM_BINARY} 
[ ! -f "$TMP/$GRADLE_BINARY" ] && curl -v -L -o $TMP/$GRADLE_BINARY https://services.gradle.org/distributions/${GRADLE_BINARY}

docker build -t ${GVM_DEMO}  .

echo " --- "
echo "now run via:  docker run -p8080:8080 -it ${GVM_DEMO} bash"
echo " --- "

