#!/bin/bash
PREFIX=192.168.56
OCTET=1
while [ "$OCTET" -lt "255" ]; do
  echo -en "Pinging ${PREFIX}.${OCTET}..."
  ping -c1 -w1 ${PREFIX}.${OCTET} >/dev/null 2>&1

  # Method-1

  # if [ "$?" -eq "0" ]; then
  #   echo "OK"
  # else
  #   echo "Failed"
  # fi

  # Method-2
  [ "$?" -eq "0" ] && echo "OK" || echo "Failed"
  let OCTET=$OCTET+1
done
