#!/bin/bash

# count arguments for scripts 

E_WRONGPARMS=85
script_params=" args1"

if [ $# -ne 1 ]
then
  echo "Usage: `basename $0` $script_params"
  exit $E_WRONGPARMS
else
  echo "your output is: $1"
fi
