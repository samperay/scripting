# Write a script adding two numbers. if two numbers are not provided it should output an error along with a usage of the script

#!/bin/bash 
if [ $# -ne 2 ]; then
	echo "needs two args"
	echo "Usage: ./add.sh arg1 arg2"
	exit 1 
else
	echo "sum of $1 and $2 = `expr $1 + $2`"
fi
