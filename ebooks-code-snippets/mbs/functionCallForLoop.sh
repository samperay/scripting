#!/bin/bash 

#Call function in 'for' loop 

generate_list(){
 	echo "one two three"
}

for word in $(generate_list)
do
  echo "$word"
done


f1() {
  echo "Hello,"$1
}

f1 $1

f2() {
  echo "$1"
}

echo Hello,$(f2 $1)
