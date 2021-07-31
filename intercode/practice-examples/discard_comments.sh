# discard the comments that are starting from start of '#' in the file

while read -r line
do
  [[ $line = \#* ]] && continue
  printf '%s\n' "$line"
done < ./passwd
