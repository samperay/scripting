#!/bin/bash

# testing equivalence


# first method

#if test -z "$1"; then 
#  echo " No command line agrs found"
#else
#  echo " First command line argument found"
#fi


# second method 

if [ -z "$1" ]; then
  echo "no cmd line args found"
else
  echo "First command line argument found"
fi
