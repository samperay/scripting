#!/usr/bin/env bash

set -x

TODODIR=~/.1todo
TODOLIST=${TODODIR}/list.txt
TODOTEMP=${TODODIR}/getTemp.txt

getCurrentVersions() {
  CURRENT_VERSION="0.0.1"
  echo "${CURRENT_VERSION}"
  exit 0
}

addTask() {
  if [ ! -d ${TODODIR} ]; then mkdir ${TODODIR}; fi
  if [ ! -f ${TODOLIST} ]; then touch ${TODOLIST}; fi
  echo "$1 " >> ${TODOLIST}
}

listTasks() {
  # check for the empty file
  if [ -f ${TODOLIST} ]; then
    checkEmpty=$(cat ${TODOLIST})
    if [[ $checkEmpty == "" ]]; then
      echo "No tasks found"
    else
      count="1"
      IFS=$'\n'
      for task in $(cat ${TODOLIST}); do
        tempTask=$count
        #if [ $count -lt 10 ]; then tempTask="0$count"; fi
        echo "$tempTask: $task"  >> ${TODOTEMP}
        count=$(( $count + 1 ))
      done
        cat ${TODOTEMP}
        rm -f ${TODOTEMP}
    fi
  else
    echo "No tasks found"
  fi
}

clearAllTasks()
{
  rm -f ${TODOLIST} || return 1
  touch ${TODOLIST} || return 1
  echo "Tasks cleared."

  exit 0
}

removeTask() {
    ## Check for valid task numbers (valid characters)
if [ -f $TODODIR/temp.txt ];then rm -f $TODODIR/temp.txt;fi
touch $TODODIR/temp.txt
for taskToRemove in "$@";do
  oldTaskNumber=$taskToRemove
  taskNumber=$( echo "$taskToRemove" | grep -Eo "[0-9]*" )
  if [[ $taskNumber == "" || $oldTaskNumber != $taskNumber ]]; then echo "Error: $oldTaskNumber is not a valid task number!" && return 1; fi
done

# count the number of lines in a file.
count="0"
IFS=$'\n'

## Removing the task (only don't add to temp if we should remove it)
for task in $(cat $TODOLIST); do
  removeIt="false"
  for taskToRemove in "$@";do
    if [[ $(($count + 1)) == "$taskToRemove" ]]; then
    removeIt="true"
    break
    fi
  done

  # write all the tasks which are not for deletion. Create a new file with tmp task list and
  # rename that back to todo list...
  if ! $removeIt ;then echo "$task" >> $TODODIR/temp.txt;fi
  count=$(( $count + 1 ))
done

# remove the todo list, copy the tmp list as the new todo list and delete the tmp file.
rm -f $TODOLIST
cp  $TODODIR/temp.txt $TODODIR/list.txt
rm -f $TODODIR/temp.txt

##Checking if the task exists
for taskToRemove in "$@" ;do
  if [ $count -lt "$taskToRemove" ]; then
    echo "Error: task number $taskToRemove does not exist!"
  else
    echo "Sucessfully removed task number $taskToRemove"
  fi
done
}

usage()
{
  cat <<EOF
todo - Easy tool to use your todo applications.

Description: A simplistic commandline todo list.
Usage: todo [flags]
  -a | add     Add the following task
  -d | del     Delete the task by mentioning the numbers
  -l | list    Lists the current tasks
  -c | clear   Clear all the current tasks
  -h | help    Shows the help
  -v | version Get the tool version
Examples:
   todo -a | add <task1>
   todo -d | del <task1
   todo -l | list
   todo -c | clear
   todo -h | help
   todo -v | version
EOF

exit 0
}


# chekc for the args

if [ $# -eq 0 ]; then
  usage
fi

case "$1" in
  -a | add)    addTask "${*:2}" && listTasks || exit 1 ;;
  -d | del)    removeTask "${*:2}" && listTasks || exit 1 ;;
  -c | clear)  clearAllTasks || exit 1 ;;
  -v | version) getCurrentVersions || exit 1 ;;
  -h | help )  usage || exit 1;;
  -l | list)   listTasks || exit 1 ;;
  *) usage || exit 1  ;;
esac
