#!/bin/bash 

# Read the file using while conditioning

while read line
do
  echo $line
done < ../passwd

# Read multiple files 

cat /tmp/file1 /tmp/file2|
while read line
do
  echo $line
done
