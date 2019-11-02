#!/bin/bash

set -x

OS=`uname -s`

NAME=helloNcurses

case "$OS" in
	Darwin) 
		INCLUDE="-I/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk/usr/include -I/Applications/Development/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include"
		;;
	*)
		INCLUDE="-I/usr/include"
		;;
esac

set -x

which clang
clang -g -emit-llvm -w -O1 -c $NAME.c -o $NAME.bc \
$INCLUDE

