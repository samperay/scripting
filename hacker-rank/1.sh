#!/bin/bash

# print odd numbers from 1..99

for i in {1..99}; do
  if [ $((i%2)) -eq 1 ]; then
    echo "$i"
  fi
done
