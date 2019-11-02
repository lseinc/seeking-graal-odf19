#!/bin/bash

set -x

OS=`uname -s`

NAME=DeferApp
typeset -l LOWER_NAME=$NAME

set -x

./$LOWER_NAME

RC=$?

if  [[ $RC -ne 0 ]]; then
  echo "If you did not build with graalvm reflection configuration, now try using the reflection configuration:"
  echo "native-image --no-fallback DeferApp -H:ReflectionConfigurationFiles=./graalvm_config.json"
fi 
