#!/bin/bash

# Generate random numbers

COUNT=0
MAX_COUNT=10

while [ "$COUNT" -le "$MAX_COUNT" ]
  do
    number=$RANDOM
    echo $number
    let "count += 1"
  done
  
