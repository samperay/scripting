# concatenate the strings

s1="Hello"
s2="Sunil"

echo "$s1 $s2"

# Concatenate of strings using arrays

arr=("Hello" "World")

for item in ${arr[@]}
do
  strnew+="$item "
done

echo ${strnew}
