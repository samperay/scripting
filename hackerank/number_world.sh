# Given two integers,  and , find their sum, difference, product, and quotient.
#
# Input Format
#
# Two lines containing one integer each ( and , respectively).
#
# Constraints
#
# Output Format
#
# Four lines containing the sum (), difference (), product (), and quotient (), respectively.
# (While computing the quotient, print only the integer part.)


#!/bin/bash

echo "Enter first number:"
read a
echo "Enter second number:"
read b

echo `expr $a + $b`
echo `expr $a - $b`
echo `expr $a \* $b`
echo `expr $a / $b`
