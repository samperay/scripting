#!/bin/bash 

# Simple Basic Calculator 


# Sum 
# Function for summing two numbers

function summing() {
  result=`expr $1 + $2`
  echo "Sum:"$result
}

# Difference 
function difference(){
  result=`expr $1 - $2`
  echo "Difference:"$result
}

# Multiplication 
function multiplication(){
  result=`expr $1 \* $2`
  echo "Multiplication:"$result
}

# Division 
function division(){
  result=`expr $1 / $2`
  echo "Division:"$result
}

summing $1 $2 
difference $1 $2
multiplication $1 $2 
division $1 $2

