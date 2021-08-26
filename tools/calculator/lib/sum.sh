#!/bin/bash
function sum() {
  local result=0
  for item in $@; do
    ((result += item))
  done
 return ${result}
}
