#!/bin/bash

todolist="./todolist"
tododone="./tododone"
# top_horizontal_line_character="_"
# bottom_horizontal_line_character='_'

# read options from cli (add,del,done,help)
readArgs() {
  options="$1"
  case $options in
    "") tododisplay "$todolist"
    ;;
    add) shift; todoadd "$@"
    ;;
    display)tododisplay "$todolist"
    ;;
    del) shift; tododel "$@"
    ;;
    erase) shift; todoerase "$@"
    ;;
    help) helpmenu
    ;;
  esac
}

erase() {
  echo -n "" > $1
}

countLines() {
  number_of_lines=$(cat $1 | wc -l | tr -d '[:space:]')
}

todoadd() {
  for item in "$@";do
    echo "$item" >> $todolist
  done
  echo "task added to your todolist"
}

tododisplay() {
  list="$1"
	countLines "$list"
  if [ $number_of_lines -eq 0 ]; then
    echo "todo list empty"
   exit 0
  fi
  echo "___"
	for i in `seq 1 $number_of_lines`
	do
		echo "$i. $(sed "${i}q;d" $list)"
	done
	echo "___"
}

todoerase() {
  # erase complete "todo" list
  if [ "$1" = "todo" ]; then
    erase "$todolist"
  fi

  # erase complete "done" task list
  if [ "$1" = "done" ]; then
    erase "$tododone"
  fi

  echo "$1's entries has been erased"
}

helpmenu() {
printf "This is TODO programm
Usage: bash todo.sh < |add|del|done|help> < |arg1,arg2,arg2>
todo.sh - display your todo-list
todo.sh done - display your done-list
todo.sh add <entry1,entry2...entryN> - add N entries to your todo-list
todo.sh del <entry1,entry2...entryN> - delete entries by their order number
!!! Deleted lines automatically append to your done-list !!!
todo.sh erase < todo|done > - erase all entries from todolist or donelist
todo.sh mv <entry1> <entry2>  - change places of entries
todo.sh stat - print statistics
todo.sh help - programm's commands and general info (you did that right now)
"
}

## Main
readArgs "$@"
