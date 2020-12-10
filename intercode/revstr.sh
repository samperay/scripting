# Find the reverse of the string

# ${parameter:offset:length}
s="sunil"
len=${#s}
echo $len

for ((i=len;i>=0;i--))
do
  reverse_string=$reverse_string${s:$i:1}
done

echo $reverse_string
