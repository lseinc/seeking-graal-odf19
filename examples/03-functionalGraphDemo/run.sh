#!/bin/bash


echo ""
echo "connect using browser to http://localhost:8084"
echo ""
set -x 

$GRAALVM_HOME/bin/node --jvm --polyglot server.js
