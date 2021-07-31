# special shell variables

#!/bin/bash
# special.sh

echo "Process ID of shell = $$"
echo "Program name = $0"
echo "Number of args = $#"
echo "Argument 1 = $1"
echo "Argument 2 = $2"
echo "Complete list of arguments = $*"
echo "Complete list of arguments = $@"

: '
$* and $@ when unquoted are identical and expand into the arguments.
"$*" is a single word, comprising all the arguments to the shell, joined together with spaces. For example '1 2' 3 becomes "1 2 3".
"$@" is identical to the arguments received by the shell, the resulting list of words completely match what was given to the shell. For example '1 2' 3 becomes "1 2" "3"
In short, $@ when quoted ("$@") breaking up the arguments if there are spaces in them. But "$*" does not breaking the arguments.
*/
'

# $* and $@ 


for i in $*
do
	echo "Without Quote $*: " $i
done

echo "------"

for i in $@
do
	echo "Without Quotes $@: " $i
done

echo "------"

for i in "$*"
do
	echo "With Quote $*: " $i
done

echo "------"

for i in "$@"
do
	echo "With Quote $@: " $i
done

echo "------"
