#!/bin/bash

todolist="./todolist"
tododone="./tododone"

# read options from cli (add,del,done,help)
readArgs() {
  options="$1"
  case $options in
    add) shift; todoadd "$@"
    ;;
    del) shift; tododel "$@"
    ;;
    erase) shift; todoerase "$@"
    ;;
    show) tododisplay "$todolist"
    ;;
    done) tododonelist "$tododone"
    ;;
    help|"-h"|"--help") helpmenu
    ;;
    "") tododisplay "$todolist"
    ;;
  esac
}

erase() {
  echo -n "" > $1
}

countLines() {
  number_of_lines=$(cat $1 | wc -l | tr -d '[:space:]')
}

# taking n ($2) line out of file ($1) and writing it to $nline
n-line ()
{
	nline=$(sed "${2}q;d" $1)
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
    echo "list's empty"
   exit 0
  fi
  echo "---------"
	for i in `seq 1 $number_of_lines`
	do
		echo "$i. $(sed "${i}q;d" $list)"
	done
	echo "---------"
}

todoerase() {

  # write a code to display message for done and todo if not entered.
  if [ -z "$1" ]; then
    echo "args needs to be passed (done/todo)"
    exit 1
  fi

  # erase complete "todo" list
  if [ "$1" = "todo" ]; then
    erase "$todolist"
    echo "todolist entries has been erased"
  fi

  # erase complete "done" task list
  if [ "$1" = "done" ]; then
    erase "$tododone"
    echo "tododone entries has been erased"
  fi
}

####DEL OPTION####
count-arguments ()
{
	nargs=0
	for n in "$@"
	do
		nargs=$((nargs+1))
	done
}

construct-array ()
{
	i=1
	for de in "$@"
  	do
  		dels[$i]=$de
  		i=$((i+1))
  	done
}

argument-in-array? ()
{
	argument=$1
	switch_aia=false
	for i in `seq 1 $nargs`
	do
		array_value=${dels[i]}
		if [ $argument = $array_value ]
		then
			switch_aia=true
		fi
	done
}

delete-tasks ()
{
	touch tmp
	countLines $todolist
	for task in `seq 1 $number_of_lines`
	do
		argument-in-array? $task
		if [ "$switch_aia" = "false" ] && [ "$task" -le "$number_of_lines" ] && [ "$task" != "0" ]
		then
			n-line $todolist $task
			echo "$nline" >> tmp
		fi
	done
	echo -n "" > $todolist
	cat tmp > $todolist
	rm tmp
}

append-deleted-tasks-to-done ()
{
	countLines $todolist
	for task in "$@"
	do
		if [ "$task" -le "$number_of_lines" ] && [ "$task" != "0" ]
		then
			n-line $todolist $task
			echo "$nline" >> $tododone
		fi
	done
}

tododel(){
  count-arguments "$@"
  construct-array "$@"
  append-deleted-tasks-to-done "$@"
  delete-tasks
  echo "Tasks has been deleted"
}

tododonelist() {
  tododisplay "$tododone"
}

helpmenu() {
printf "TODO Program
------------
Usage: ./todo.sh < |add|del|done> < |arg1,arg2,arg2>
       todo.sh - display your todo-list
       todo.sh done - display your done-list
       todo.sh add <entry1,entry2...entryN> - add N entries to your todo-list
       todo.sh del <entry1,entry2...entryN> - delete entries by their order number

       INFO: !!! Deleted lines automatically append to your done-list !!!

       todo.sh erase < todo|done > - erase all entries from todolist or donelist
       todo.sh help|-h|--help - programm's commands and general info"
}

## Main
readArgs "$@"

exit 0
