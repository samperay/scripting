LIBPATH="${PWD}/$(dirname $0)/../lib"
. ${LIBPATH}/setup.env
. ${LIBPATH}/sum.sh
argscli=$(argsPassed $*)

if [[ $? -ne 0 ]]; then 
  sumresult=$(sum "$@")
  echo "Sum: " $?
else 
   usage
fi
