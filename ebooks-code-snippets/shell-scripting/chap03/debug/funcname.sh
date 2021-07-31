#!/bin/bash
function func1()
{
  echo "func1: FUNCNAME0 is ${FUNCNAME[0]}"
  echo "func1: FUNCNAME1 is ${FUNCNAME[1]}"
  echo "func1: FUNCNAME2 is ${FUNCNAME[2]}"
  echo "func1: LINENO is ${LINENO}"
  func2
}

function func2()
{
echo "func2: FUNCNAME0 is ${FUNCNAME[0]}"
echo "func2: FUNCNAME1 is ${FUNCNAME[1]}"
echo "func2: FUNCNAME2 is ${FUNCNAME[2]}"
echo "func2: LINENO is ${LINENO}"
}

func1


# ./funcname.sh -> on executing this,
# ${FUNCNAME[0] = name of the function you are in.
# ${FUNCNAME[1] = function that called you
# ${FUNCNAME[2] = actually the main script.
