#!/bin/bash 

# Pattern matching parameter substitution

var1=abcd12345abc6789
pattern1=a*c  # * (wild card) matches everything between a - c.
pattern2=b*9
echo
echo "var1 = $var1"       	# abcd12345abc6789
echo "var1 = ${var1}"     	# abcd12345abc6789
echo "Number of characters in ${var1} = ${#var1}"
echo
 
# Shortest possible match, strips first 3 characters
### always '#' starts from the beginning to the end of the string ###
echo shortest match from Begin - End of string = "${var1#$pattern1}"
  
# Longest possible match, strips first 12 characters
echo longest match from Begin - End of string = "${var1##$pattern1}"
 
# Shortest possible match, strips first 3 characters 
### always '%' starts from the end to the beginning of the string ###
echo shortest match from End - Beginning of the string = "${var1%$pattern2}"
  
# Longest possible match, strips first 12 characters 
echo longest match from End - Beginning of the string = "${var1%%$pattern2}"
 
var3=abcd-1234-defg
echo "var3 = $var3"

#Works only with single '#' from Begin - End 
t=${var3#*-*}
echo Begin - End: $t
 
#Works only with single '%' from End - Begin 
t=${var3%*-*}
echo End - Begin: $t

