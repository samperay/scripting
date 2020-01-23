#!/bin/bash

# compare two files

E_SUCCESS=0
E_ARGNOTFOUND=85
E_FILENOTFOUND=86
ARGS_COUNT=2

if [ $# -eq 0 ]; then
  echo "Usage: `basename $0` [ file1 ] [ file2 ]"
  exit $E_ARGNOTFOUND
fi

file1=$1
file2=$2

if [ ! -f "$file1" ];then
  echo "$file1 not found, exiting.. !"
  exit $E_FILENOTFOUND

  elif [ ! -f "$file2" ]; then
    echo "$file2 not found, exiting.. !"
  exit $E_FILENOTFOUND
fi

if cmp "$file1" "$file2"; then 
  echo "files are identical"
else
  echo "files are not identical"
fi

exit $E_SUCCESS
