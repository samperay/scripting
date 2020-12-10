# print sim of odd numnbers

oddsum=0
for i in {1..10..2}
do
 oddsum=$((oddsum+i))
done

echo $oddsum
