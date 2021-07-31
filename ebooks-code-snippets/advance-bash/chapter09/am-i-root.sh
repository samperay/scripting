#!/bin/bash

# check if you are root user

ROOT_UID=0

if [ "$UID" -eq "$ROOT_UID" ]; then
  echo "You are root !"
else
  echo "You are non root"
fi

exit 0
