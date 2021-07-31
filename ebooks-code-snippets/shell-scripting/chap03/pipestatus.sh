ls $dir | grep $goodthing | grep -v $badthing
echo ${PIPESTATUS[*]} | grep -v 0 > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
  echo "Something in the pipeline failed."
else
  echo "Only good things were found in $dir, no bad things were found. Phew!"
fi
