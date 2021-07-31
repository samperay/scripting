#!/bin/bash

# testing file exists or not

FILE="/etc/passwd"

if [[ -e $FILE ]]
then
  echo "File exists !"
fi
