# Calculate sum of integers from 1 to 100 

sum=0
for i in {1..100}
do 
	sum=$((sum+i))
done
echo "Sum:"$sum
