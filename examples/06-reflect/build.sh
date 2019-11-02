#!/bin/bash

set -x

OS=`uname -s`

NAME=DeferApp
typeset -l LOWER_NAME=$NAME

set -x

which java
rm -f *.class $LOWER_NAME
javac *.java

echo "build with native image"
native-image --no-fallback DeferApp

