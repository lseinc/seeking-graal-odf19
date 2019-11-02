#!/bin/bash

java -Diterations=4 -Dgraal.PrintCompilation=true CountUppercase `cat input.txt`
