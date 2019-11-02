# Demo some performance info


This set of files came from the repository for [GraalVM](graalvm.org).

## Prerequisites
* [GraalVM](http://graalvm.org)
* $GRAALVM_HOME variable should point to the installation folder.
* PATH should include $GRAALVM_HOME/bin .

## Build & Run
- ./build.sh        # javac CountUppercase.java
- ./run-without.sh  # runs normal Java Runtime Environment without GraalVM engine.
- ./run-graalvm.sh  # runs GraalVM engine with trace of JIT compilation.


