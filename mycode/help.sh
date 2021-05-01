#!/bin/bash

function help() {
   echo "Add description of the script functions here."
   echo
   echo "Syntax: scriptTemplate [-h|-v]"
   echo "options:"
   echo "-h     Print this Help."
   echo "-v     Print software version and exit."
   echo
}

while getopts ":hv" option
do
  case ${option} in 
    "h") help ;;
    "v") echo 12.10.10 ;;
    "*") echo "Error: Invalid Option" || exit 
  esac
done

