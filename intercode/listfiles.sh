#!/bin/bash 

# list the files in the folder
echo "printing list of files in the directory"

for item in /etc/*
do
  if [ -f $item ]; then 
    echo ${item}
  fi
done
