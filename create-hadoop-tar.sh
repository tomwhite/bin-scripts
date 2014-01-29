#!/bin/bash

set -e
set -x

bin=`dirname "$0"`
bin=`cd "$bin"; pwd`

VERSION=0.23-SNAPSHOT
WORKSPACE=~/workspace
cd $WORKSPACE

export COMMON_JVM_OPTIONS="-Dfindbugs.home=$FINDBUGS_HOME -Dforrest.home=$FORREST_HOME -Djava5.home=$JAVA5_HOME -Dresolvers=internal"

pushd hadoop-common-trunk
$ANT_HOME/bin/ant $COMMON_JVM_OPTIONS veryclean tar mvn-install
popd
pushd hadoop-hdfs-trunk
$ANT_HOME/bin/ant $COMMON_JVM_OPTIONS veryclean tar mvn-install
popd
pushd hadoop-mapreduce-trunk
$ANT_HOME/bin/ant $COMMON_JVM_OPTIONS veryclean tar mvn-install
popd

$bin/tar-munge $VERSION $WORKSPACE/hadoop-{common,hdfs,mapreduce}-trunk/build/*.tar.gz