# Problem Statement

#Given three integers (, , and ) representing the three sides of a triangle, identify whether the triangle is scalene, isosceles, or equilateral.

#If all three sides are equal, output EQUILATERAL. 
#Otherwise, if any two sides are equal, output ISOSCELES.
#Otherwise, output SCALENE.

# constraints
# The sum of any two sides will be greater than the third.

#!/bin/bash 

read x;
read y;
read z;
if [ $x -eq $y ] && [ $y -eq $z ]
then
  echo "EQUILATERAL";
elif [ $x -ne $y ] && [ $x -ne $z ] && [ $y -ne $z ]
then
  echo "SCALENE";
else
  echo "ISOSCELES";
fi

