#!/bin/bash

#set -x

NAME=helloNcurses
OS=`uname -s`

case "$OS" in
	Darwin) 
		LIB="--lib /usr/lib/libncurses.dylib"
		DYLD_FALLBACK_LIBRARY_PATH=/usr/lib
		;;
	*)
		LIB="--lib /lib/x86_64-linux-gnu/libncurses.so.5"
		LD_LIBRARY_PATH=/usr/lib:/lib/x86_64-linux-gnu/
		;;
esac

set -x

which lli

lli  \
$LIB \
$NAME.bc

