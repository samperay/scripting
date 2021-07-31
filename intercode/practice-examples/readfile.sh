#!/bin/bash 

# Read a file till the EOF

echo "Using while loop to read file"

while read LINE
do
  echo $LINE
done</etc/passwd
