#!/bin/bash

# Return sum of integers
function sum() {
  local result=0
  for item in "$@"; do
    result=$((result += item))
  done
  return ${result}
}

# Return difference of integers
function diff() {
  local result=0
  array_list=("$@")
  var1="${array_list[1]}"
  var2="${array_list[2]}"
  #result=$(expr $var1 - $var2 )
  result=$(echo "$var1-$var2"|bc)
  #return ${result}
}

# Return difference of integers
function mul() {
  local result=1
  array_list=("$@")
  var1=${array_list[1]}
  var2=${array_list[2]}
  result=$((${var1} * ${var2}))
  echo "product:" ${result}
}
