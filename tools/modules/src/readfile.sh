#!/bin/bash 

LIB_PATH="$PWD/$(dirname $0)/../lib/init.sh"
cd /var/tmp
if [[ ${PALTFORM}=="Linux" ]]
then 
  echo "This is from Linux machine .. "
  CI="/etc/passwd"
  for eachline in `cat $CI | awk -F":" '{print $1}'`
  do
    echo $eachline
  done
else
  echo "This script is of no use in this OS"
fi
