#!/bin/bash


echo ""
echo "setting up npm and building..."
echo ""
set -x 

$GRAALVM_HOME/bin/npm install
$GRAALVM_HOME/bin/npm build
