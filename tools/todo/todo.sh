#!/bin/bash

todolist="./todolist"
tododone="./tododone"

# read options from cli (add,del,done,help)
readArgs() {
  options="$1"
  case $options in
    add) shift; todoadd "$@"
    ;;
    display) tododisplay "$todolist"
    ;;
    help) helpmenu
    ;;
  esac
}

todoadd() {
  for item in "$@";do
    echo "$item" >> $todolist
  done
  echo "task added to your todolist"
}

tododisplay() {
  items="$1"
  for item in `cat $todolist`; do
    echo "$item"
  done
}

## Main
readArgs "$@"
