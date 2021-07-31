#!/bin/bash 

# Counting the lines in the file 
# Usage: ./line_count.sh file

exec 10<&0
exec < $1

in=$1
file=/tmp/tmppasswd
let count=0

while read LINE
do
  ((count++))
  echo $LINE > $file
done

echo "No of lines:" ${count}

exec 0<&10 10<&-
