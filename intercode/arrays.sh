# arrays 

# Define the array 
numbers=("1" "2" "3" "4")

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
