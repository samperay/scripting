# Problem Statement

#Given three integers (, , and ) representing the three sides of a triangle, identify whether the triangle is scalene, isosceles, or equilateral.

#If all three sides are equal, output EQUILATERAL. 
#Otherwise, if any two sides are equal, output ISOSCELES.
#Otherwise, output SCALENE.

# constraints
# The sum of any two sides will be greater than the third.

#!/bin/bash 

a=$1
b=$2
c=$3

if [[ ${a} == ${b} ]] && [[ ${b} == ${c} ]] && [[ ${c} == ${a} ]]
then
  echo EQUILATERAL
elif [[ ${a} == ${b} ]] || [[ ${a} == ${c} ]] || [[ ${b} == ${c} ]]
then
  echo ISOSCELES
else 
  echo SCALENE
fi
