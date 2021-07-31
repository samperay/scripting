#!/bin/bash

# compare two files using functions

# Return values

E_NONARGS=85

strcmp () {
  if cmp "$1" "$2"; then
    echo 'files identical'
  else
    echo 'files not identical'
  fi

}


if [ $# -eq 0 ]; then 
  echo "Usage: ./`basename $0` arg1 arg2"
  exit $E_NONARGS
fi
strcmp "$1" "$2"
