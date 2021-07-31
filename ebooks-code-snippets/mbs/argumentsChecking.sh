#!/bin/bash 

# Methods for argument checking

# Method-1

if [ $# -eq 0 ]; then 
  echo "Usage: ./script <args>"
else
  echo "Method-1: arguments taken"
fi


# Method-2 

if [ ! -n "$1" ]; then 
  echo "Usage: ./script <args>"
else
  echo "Method-2: arguments taken"
fi

# Method-3 

: ${
