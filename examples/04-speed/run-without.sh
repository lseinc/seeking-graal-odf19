#!/bin/bash

java -XX:-UseJVMCICompiler -Diterations=4 -Dgraal.PrintCompilation=true CountUppercase `cat input.txt`
