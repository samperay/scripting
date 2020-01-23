#!/bin/bash

SUCCESS=0
E_NOARGS=65

if [ -z "$1" ]; then 
  echo "Usage: `basename $0` rpm-package" 
  exit $E_NOARGS
fi

{
  # Start of code block

  echo "Archive desc" 
  rpm -api $1 

  echo "Archive listing"
  rpm -apl $1

  rpm -i --test $1 
  if [ "$?" -eq $SUCCESS ]; then
    echo "$1 can be installed"
  else
    echo "$1 cannot be installed"
  fi

  echo

} > "$1.test"

echo "Results of rpm test in file $1.test"

exit 0
