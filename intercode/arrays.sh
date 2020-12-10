# arrays 

# Define the array  - Method 1 
numbers=("1" "2" "3" "4")

# Define the array - Method 2 
num[0]="one"
num[1]="two"

echo ${num[*]}

# Get length of array 
echo "length of array:" ${#numbers[*]}

# Get all the elements in an array 
echo ${numbers[@]}
echo "-------"

# Get first and second element of an array 
echo "First Element: "${numbers[0]} 
echo "Second Element: "${numbers[1]} 
echo "-------"

# Traversing an array of elemets 
for item in ${numbers[@]}
do
	echo "Traverse using $@: "$item
done
echo "--------"

for item in ${numbers[*]}
do
	echo "Traverse using $*: "$item
done

echo "--------"

# print array index 
for index in ${!numbers[*]}
do
  echo "Index:" $index
done

echo "--------"
# "${numbers[@]}" - returns each item as a separate word.
# "${numbers[*]}" - returns all items in a word.

# Iterate an array finding its length
len=${#numbers[@]}
for ((i=0;i<len;i++))
do
  echo Index:$i,each element:${numbers[$i]}
done
