#!/bin/bash 

# Find all executable files ending in "calc" in /bin and /usr/bin directories

for file in /{,usr/}bin/*calc
do
    	if [ -x "$file" ]
    	then
                echo $file
    	fi
done

