#!/bin/bash 

#  Parameter substitution and error messages 

: ${HOSTNAME?} ${USER} ${HOME}
echo
echo "Name of the machine:$HOSTNAME"
echo "You are the $USER"
echo "$HOME home directory"
echo

: ${sunil?"ERROR MESSAGE"}
