#!/bin/bash 

# Different types of loops 

# for loop, lists all the files in the current directory

echo "forloop: listing all files in the PWD"
for i in *
do 
  echo $i
done
echo " ------------ EOFloop ---------------"

echo "forloop: specific direcotry"
for i in /etc/*
do echo $i
done
echo " ------------ EOFloop ---------------"

# while loop 
n=10
while [ $n -ge 0 ]
do
  echo $n 
  (( n-- ))
done
