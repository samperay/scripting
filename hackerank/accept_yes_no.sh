# Problem Statement

#Read in one character from STDIN.

#If the character is 'Y' or 'y' display "YES".
#If the character is 'N' or 'n' display "NO".
#No other character will be provided as input.

# Solution

#!/bin/bash
read -p 'Enter one char(y/Y) or (N/n):' ch
# find the lenght of the input string 
varlen=${#ch}

if [ ${varlen} -gt 2 ]
then  
  echo "Only one character accepted"
  exit 1
fi

if [ ${ch} = "y" ]
then 
  echo "YES"
elif [ ${ch} = "Y" ]
then
  echo "YES"
fi

if [ ${ch} = "n" ]
then 
  echo "NO"
elif [ ${ch} = "N" ]
then
  echo "NO"
fi


