#!/bin/bash

# Counting to 11 in 10 different ways.

n=1; echo -n "$n "
let "n = $n + 1"   # let "n = n + 1"  also works.
echo -n "$n "
: $((n = $n + 1))
echo -n "$n "
(( n = n + 1 ))
echo -n "$n "
n=$(($n + 1))
echo -n "$n "
: $[ n = $n + 1 ]
echo -n "$n "
n=$[ $n + 1 ]
echo -n "$n "

let "n++"      	# let "++n"  also works.
echo -n "$n "
(( n++ ))          # (( ++n )  also works.
echo -n "$n "
: $(( n++ ))       # : $(( ++n )) also works.
echo -n "$n "
: $[ n++ ]         # : $[ ++n ]] also works
echo -n "$n "
echo
exit 0

