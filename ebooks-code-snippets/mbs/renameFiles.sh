#!/bin/bash 

# Rename all filenames in $PWD with "TXT" suffix to a "txt" suffix

SUFF=TXT
suff=txt
 
for i in $(ls *.$SUFF)
do
    	mv -f $i ${i%.$SUFF}.$suff
done
 
who | grep nobody | sort
echo ${PIPESTATUS[*]}

