#!/bin/bash
trap cleanup 1 2 3 15
cleanup()
{
  echo "function name: ${FUNCNAME[0]}"
  echo "I was running \"$BASH_COMMAND\" when you INT me"
  echo "Quitting.."
  exit 1
}

while :
  do
    echo -en "Hello..,lineno: $LINENO"
    sleep 1
    echo -en "my..,lineno: $LINENO "
    sleep 1
    echo -en "name..,lineno: $LINENO"
    sleep 5
  done
