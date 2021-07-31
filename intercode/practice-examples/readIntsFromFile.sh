#!/bin/bash

# Read the list of sqeuence from other files and check the return status

./countIntegers.sh &
wait

if [ $? -eq 0 ]
then 
  echo "Return Status of previous command: Success"
else
  echo "Return Status of previous command: Failure"
fi
