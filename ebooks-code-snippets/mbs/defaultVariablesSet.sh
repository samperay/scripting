#!/bin/bash

# set the default dirs to some value if none of the args set

# Normal Method
#args=1

#if [ $# -ne $args ]; then
#  directory=`pwd`
#else 
#  directory=$1
#fi

# or

# shell single line

directory=${1-`pwd`}
echo $directory

