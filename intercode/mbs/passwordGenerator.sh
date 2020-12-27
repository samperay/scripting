#!/bin/bash 

# Generating an 8-character "random" string

if [ -n "$1" ]; then
        str0="$1"
else
        str0="$$"
fi
 
POS=2
LEN=8
 
str1=$( echo "$str0" | md5sum | md5sum )
 
randstring="${str1:$POS:$LEN}"
 
echo "Defaults to 8-char length of random chars: $randstring"

# Second Method 
echo "You are welcome to enter length of chars "

# read the input given by user and store in variable 
read PASS_LENGTH 

# loop will create 5 passwords according to 
# user as per length given by user						 
for p in $(seq 1 5);								 
do 
	openssl rand -base64 48 | cut -c1-$PASS_LENGTH 
done 

