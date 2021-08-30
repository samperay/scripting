LIBPATH="${PWD}/$(dirname $0)/../lib"
source ${LIBPATH}/setup.env
source ${LIBPATH}/calculations.sh

# check for arguments passed to function for math required to
# have exactly two operators
([ "$#" -eq "0" ] || [ "$#" -eq "1" ])&& usage && exit 1
[ "$#" -le "2" ] && usage && exit 1

# Start of the program
while [ "$#" -gt 0 ]; do
  case "$1" in
    # return result from called function
    -s| -sum)
      sum "$@"
      echo "Sum: " $?
      exit 0
      ;;
    # return result from called function
    -d| -diff)
      diff "$@"
      echo "Difference: " $?
      exit 0
      ;;
    # Print result in function.
    -m| -mul)
      mul "$@"
      exit 0
      ;;
    *)
      usage
      exit 1
      ;;
  esac
done
